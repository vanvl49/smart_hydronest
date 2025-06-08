#include <ESP32Servo.h>
#include <DHT.h>
#include <WiFi.h>
#include <PubSubClient.h>
#include <ArduinoJson.h>

// WIFI
const char *ssid = "GalaxyA23";
const char *password = "okus1181";

// MQTT
const char *mqttserver = "broker.hivemq.com";
const int mqttPort = 1883;
const char *mqtt_topic_sub = "f01a1027-ed41-4874-ab2c-21e211727e96";
const char *mqtt_topic_pub = "smart-hydronest/sensor-data";

WiFiClient espClient;
PubSubClient client(espClient);

// Pin
const int ldrPin = 34;
const int servoPin = 18;
const int servoPin2 = 19;
const int RELAY_PIN = 16; // Digunakan untuk pompa 12V
#define DHTPIN 5
#define DHTTYPE DHT11

// Batas default
int BatasBawahCahaya = 2000;
int BatasAtasCahaya = 1000;
float BatasAtasSuhu = 28.0;
float BatasBawahSuhu = 27.0;

// Mode kontrol
bool modeAtapManual = false;
bool modePompaManual = false;
bool servo_ON = false;
bool relay_ON = false;

Servo atap;
Servo atap2;
DHT dht(DHTPIN, DHTTYPE);

// Sensor Cahaya
class SensorCahaya
{
public:
    int baca()
    {
        return analogRead(ldrPin);
    }

    void kontrolAtap(int nilai)
    {
        if (nilai < BatasAtasCahaya)
        {
            atap.write(90);
            atap2.write(90);
            servo_ON = true;
        }
        else if (nilai > BatasBawahCahaya)
        {
            atap.write(0);
            atap2.write(0);
            servo_ON = false;
        }
    }
};

// Sensor Suhu
class SensorSuhu
{
public:
    float baca()
    {
        return dht.readTemperature();
    }

    void kontrolPompa(float nilai)
    {
        if (nilai > BatasAtasSuhu)
        {
            digitalWrite(RELAY_PIN, HIGH);
            relay_ON = true;
        }
        else if (nilai < BatasBawahSuhu)
        {
            digitalWrite(RELAY_PIN, LOW);
            relay_ON = false;
        }
    }
};

SensorCahaya cahaya;
SensorSuhu suhu;

// MQTT Callback
void callback(char *topic, byte *payload, unsigned int length)
{
    String message;
    for (unsigned int i = 0; i < length; i++)
    {
        message += (char)payload[i];
    }

    if (String(topic) == "hidroponik/mode/atap")
    {
        modeAtapManual = (message == "manual");
    }

    else if (String(topic) == "hidroponik/mode/pompa")
    {
        modePompaManual = (message == "manual");
    }

    else if (String(topic) == "hidroponik/control/atap")
    {
        if (modeAtapManual)
        {
            if (message == "tutup")
            {
                atap.write(90);
                atap2.write(90);
                servo_ON = true;
            }
            else if (message == "buka")
            {
                atap.write(0);
                atap2.write(0);
                servo_ON = false;
            }
        }
    }

    else if (String(topic) == "hidroponik/control/pompa")
    {
        if (modePompaManual)
        {
            if (message == "on")
            {
                digitalWrite(RELAY_PIN, HIGH);
                relay_ON = true;
            }
            else if (message == "off")
            {
                digitalWrite(RELAY_PIN, LOW);
                relay_ON = false;
            }
        }
    }

    else if (String(topic) == "hidroponik/batas/suhu")
    {
        StaticJsonDocument<128> doc;
        DeserializationError error = deserializeJson(doc, message);

        if (!error)
        {
            float suhuMin = doc["suhu_min"];
            float suhuMax = doc["suhu_max"];

            if (suhuMin >= 5.0 && suhuMax <= 60.0 && suhuMin < suhuMax)
            {
                BatasBawahSuhu = suhuMin;
                BatasAtasSuhu = suhuMax;
                Serial.print("Batas suhu diperbarui: ");
                Serial.print(BatasBawahSuhu);
                Serial.print(" - ");
                Serial.println(BatasAtasSuhu);
            }
            else
            {
                Serial.println("Format suhu tidak valid.");
            }
        }
        else
        {
            Serial.println("Gagal parsing JSON suhu.");
        }
    }

    else if (String(topic) == "hidroponik/batas/cahaya")
    {
        StaticJsonDocument<128> doc;
        DeserializationError error = deserializeJson(doc, message);

        if (!error)
        {
            int cahayaMin = doc["cahaya_min"];
            int cahayaMax = doc["cahaya_max"];

            if (cahayaMin > cahayaMax && cahayaMin <= 4095 && cahayaMax >= 0)
            {
                BatasBawahCahaya = cahayaMin;
                BatasAtasCahaya = cahayaMax;
                Serial.print("Batas cahaya diperbarui: ");
                Serial.print(BatasBawahCahaya);
                Serial.print(" - ");
                Serial.println(BatasAtasCahaya);
            }
            else
            {
                Serial.println("Format cahaya tidak valid.");
            }
        }
        else
        {
            Serial.println("Gagal parsing JSON cahaya.");
        }
    }
}

// MQTT Reconnect
void reconnect()
{
    while (!client.connected())
    {
        Serial.print("Menghubungkan ke MQTT...");
        if (client.connect("ESP32HidroponikClient"))
        {
            Serial.println("Berhasil!");
            client.subscribe(mqtt_topic_sub);
            client.subscribe("hidroponik/control/atap");
            client.subscribe("hidroponik/control/pompa");
            client.subscribe("hidroponik/batas/suhu");
            client.subscribe("hidroponik/batas/cahaya");
            client.subscribe("hidroponik/mode/atap");
            client.subscribe("hidroponik/mode/pompa");
        }
        else
        {
            Serial.print("Gagal, kode: ");
            Serial.println(client.state());
            delay(2000);
        }
    }
}

// Setup
void setup()
{
    Serial.begin(115200);
    Serial.println("Booting...");
    atap.attach(servoPin);
    atap2.attach(servoPin2);
    pinMode(RELAY_PIN, OUTPUT);
    digitalWrite(RELAY_PIN, LOW); // Pompa mati saat awal
    dht.begin();

    WiFi.begin(ssid, password);
    while (WiFi.status() != WL_CONNECTED)
    {
        delay(500);
        Serial.print(".");
    }
    Serial.println("\nWiFi Terhubung.");

    client.setServer(mqttserver, mqttPort);
    client.setCallback(callback);
}

// Loop
void loop()
{
    if (!client.connected())
        reconnect();
    client.loop();

    int nilaiCahaya = cahaya.baca();
    float nilaiSuhu = suhu.baca();

    if (!modeAtapManual)
    {
        cahaya.kontrolAtap(nilaiCahaya);
    }

    if (!modePompaManual)
    {
        suhu.kontrolPompa(nilaiSuhu);
    }

    // === Input Serial Manual untuk Pompa ===
    if (Serial.available())
    {
        String input = Serial.readStringUntil('\n');
        input.trim();

        if (input == "manual-pompa")
        {
            modePompaManual = true;
            Serial.println("Mode pompa: MANUAL");
        }
        else if (input == "otomatis-pompa")
        {
            modePompaManual = false;
            Serial.println("Mode pompa: OTOMATIS");
        }
        else if (input == "on" && modePompaManual)
        {
            digitalWrite(RELAY_PIN, HIGH);
            relay_ON = true;
            Serial.println("Pompa dinyalakan secara manual");
        }
        else if (input == "off" && modePompaManual)
        {
            digitalWrite(RELAY_PIN, LOW);
            relay_ON = false;
            Serial.println("Pompa dimatikan secara manual");
        }
        else
        {
            Serial.println("Perintah tidak dikenal atau mode tidak sesuai");
        }
    }

    Serial.print("Cahaya: ");
    Serial.print(nilaiCahaya);
    Serial.print(" | Suhu: ");
    Serial.print(nilaiSuhu);
    Serial.print(" °C");
    Serial.print(" | Status Pendingin: ");
    Serial.print(relay_ON);
    Serial.print(" | Status Penutup: ");
    Serial.println(servo_ON);

    String payload = "{"
                     "\"cahaya\": " +
                     String(nilaiCahaya) +
                     ", \"suhu\": " + String(nilaiSuhu) +
                     ", \"relay\": " + (relay_ON ? "true" : "false") +
                     ", \"atap\": " + (servo_ON ? "true" : "false") +
                     "}";

    client.publish(mqtt_topic_pub, payload.c_str());

    delay(2000);
}