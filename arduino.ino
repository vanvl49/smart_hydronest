#include <ESP32Servo.h>
#include <DHT.h>
#include <WiFi.h>
// #include <WiFiClientSecure.h>
#include <PubSubClient.h>
#include <UniversalTelegramBot.h>
#include <ArduinoJson.h>

// WIFI
const char* ssid = "BLUE";
const char* password = "azmahil21";

// MQTT
// const char* mqttserver = "4bce82dc24764c06a01c44463ba43bc8.s1.eu.hivemq.cloud";
const char* mqttserver = "broker.hivemq.com";
// const char* mqtt_username = "pplc1";
// const char* mqtt_password = "Pplc11234";
// const int mqttPort = 8883;
const int mqttPort = 1883;
const char* mqtt_topic_sub = "f01a1027-ed41-4874-ab2c-21e211727e96";
const char* mqtt_topic_pub = "smart-hydronest/sensor-data";

// WiFiClientSecure espClient;
WiFiClient espClient;
PubSubClient client(espClient);

// static const char *root_ca PROGMEM = R"EOF(
// -----BEGIN CERTIFICATE-----
// MIIFazCCA1OgAwIBAgIRAIIQz7DSQONZRGPgu2OCiwAwDQYJKoZIhvcNAQELBQAw
// TzELMAkGA1UEBhMCVVMxKTAnBgNVBAoTIEludGVybmV0IFNlY3VyaXR5IFJlc2Vh
// cmNoIEdyb3VwMRUwEwYDVQQDEwxJU1JHIFJvb3QgWDEwHhcNMTUwNjA0MTEwNDM4
// WhcNMzUwNjA0MTEwNDM4WjBPMQswCQYDVQQGEwJVUzEpMCcGA1UEChMgSW50ZXJu
// ZXQgU2VjdXJpdHkgUmVzZWFyY2ggR3JvdXAxFTATBgNVBAMTDElTUkcgUm9vdCBY
// MTCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBAK3oJHP0FDfzm54rVygc
// h77ct984kIxuPOZXoHj3dcKi/vVqbvYATyjb3miGbESTtrFj/RQSa78f0uoxmyF+
// 0TM8ukj13Xnfs7j/EvEhmkvBioZxaUpmZmyPfjxwv60pIgbz5MDmgK7iS4+3mX6U
// A5/TR5d8mUgjU+g4rk8Kb4Mu0UlXjIB0ttov0DiNewNwIRt18jA8+o+u3dpjq+sW
// T8KOEUt+zwvo/7V3LvSye0rgTBIlDHCNAymg4VMk7BPZ7hm/ELNKjD+Jo2FR3qyH
// B5T0Y3HsLuJvW5iB4YlcNHlsdu87kGJ55tukmi8mxdAQ4Q7e2RCOFvu396j3x+UC
// B5iPNgiV5+I3lg02dZ77DnKxHZu8A/lJBdiB3QW0KtZB6awBdpUKD9jf1b0SHzUv
// KBds0pjBqAlkd25HN7rOrFleaJ1/ctaJxQZBKT5ZPt0m9STJEadao0xAH0ahmbWn
// OlFuhjuefXKnEgV4We0+UXgVCwOPjdAvBbI+e0ocS3MFEvzG6uBQE3xDk3SzynTn
// jh8BCNAw1FtxNrQHusEwMFxIt4I7mKZ9YIqioymCzLq9gwQbooMDQaHWBfEbwrbw
// qHyGO0aoSCqI3Haadr8faqU9GY/rOPNk3sgrDQoo//fb4hVC1CLQJ13hef4Y53CI
// rU7m2Ys6xt0nUW7/vGT1M0NPAgMBAAGjQjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNV
// HRMBAf8EBTADAQH/MB0GA1UdDgQWBBR5tFnme7bl5AFzgAiIyBpY9umbbjANBgkq
// hkiG9w0BAQsFAAOCAgEAVR9YqbyyqFDQDLHYGmkgJykIrGF1XIpu+ILlaS/V9lZL
// ubhzEFnTIZd+50xx+7LSYK05qAvqFyFWhfFQDlnrzuBZ6brJFe+GnY+EgPbk6ZGQ
// 3BebYhtF8GaV0nxvwuo77x/Py9auJ/GpsMiu/X1+mvoiBOv/2X/qkSsisRcOj/KK
// NFtY2PwByVS5uCbMiogziUwthDyC3+6WVwW6LLv3xLfHTjuCvjHIInNzktHCgKQ5
// ORAzI4JMPJ+GslWYHb4phowim57iaztXOoJwTdwJx4nLCgdNbOhdjsnvzqvHu7Ur
// TkXWStAmzOVyyghqpZXjFaH3pO3JLF+l+/+sKAIuvtd7u+Nxe5AW0wdeRlN8NwdC
// jNPElpzVmbUq4JUagEiuTDkHzsxHpFKVK7q4+63SM1N95R1NbdWhscdCb+ZAJzVc
// oyi3B43njTOQ5yOf+1CceWxG1bQVs5ZufpsMljq4Ui0/1lvh+wjChP4kqKOJ2qxq
// 4RgqsahDYVvTH9w7jXbyLeiNdd8XM2w9U/t7y0Ff/9yi0GE44Za4rF2LN9d11TPA
// mRGunUHBcnWEvgJBQl9nJEiU0Zsnvgc/ubhPgXRR4Xq37Z0j4r7g1SgEEzwxA57d
// emyPxgcYxn/eR44/KJ4EBs+lVDR3veyJm+kXQ99b21/+jh5Xos1AnX5iItreGCc=
// -----END CERTIFICATE-----
// )EOF";

//TELEGRAM BOT
// #define BOT_TOKEN "8177103361:AAFfXFRkSyxgn0PxSzKAe125hVJ0VhTjQ38"  // your Bot Token (Get from Botfather)
// // #define CHAT_ID "-4825881490"
// #define CHAT_ID "-4825881490"

// UniversalTelegramBot bot(BOT_TOKEN, espClient);

// Pin
const int ldrPin = 34;
const int servoPin = 14;
const int servoPin2 = 19;
const int RELAY_PIN = 22;  // Digunakan untuk pompa 12V
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
class SensorCahaya {
  public:
    int baca() {
      return analogRead(ldrPin);
    }

    void kontrolAtap(int nilai) {
      if (nilai < BatasAtasCahaya) {
        atap.write(90);
        atap2.write(90);
        servo_ON = true;
        // bot.sendMessage(CHAT_ID, "Penutup ruangan aktif", "");
      } else if (nilai > BatasBawahCahaya) {
        atap.write(0);
        atap2.write(0);
        servo_ON = false;
        // bot.sendMessage(CHAT_ID, "Penutup ruangan nonaktif", "");
      }
    }
};

// Sensor Suhu
class SensorSuhu {
  public:
    float baca() {
      return dht.readTemperature();
    }

    void kontrolPompa(float nilai) {
      // Serial.print("Nilai suhu: ");
      // Serial.println(nilai);
      // Serial.print("Nilai batas suhu atas: ");
      // Serial.println(BatasAtasSuhu);
      // Serial.print("Nilai batas suhu bawah: ");
      // Serial.println(BatasBawahSuhu);
      if (nilai > BatasAtasSuhu) {
        digitalWrite(RELAY_PIN, HIGH);
        relay_ON = true;
        // bot.sendMessage(CHAT_ID, "Pendingin ruangan aktif", "");
      } else if (nilai < BatasBawahSuhu) {
        digitalWrite(RELAY_PIN, LOW);
        relay_ON = false;
        // bot.sendMessage(CHAT_ID, "Pendingin ruangan nonaktif", "");
      }
    }
};

SensorCahaya cahaya;
SensorSuhu suhu;

// MQTT Callback
void callback(char* topic, byte* payload, unsigned int length) {
  String message;
  for (unsigned int i = 0; i < length; i++) {
    message += (char)payload[i];
  }

  if (String(topic) == "hidroponik/mode/atap") {
    modeAtapManual = (message == "manual");
  }

  else if (String(topic) == "hidroponik/mode/pompa") {
    modePompaManual = (message == "manual");
  }

  else if (String(topic) == "hidroponik/control/atap") {
    if (modeAtapManual) {
      if (message == "tutup") {
        atap.write(90);
        atap2.write(90);
        servo_ON = true;
      } else if (message == "buka") {
        atap.write(0);
        atap2.write(0);
        servo_ON = false;
      }
    }
  }

  else if (String(topic) == "hidroponik/control/pompa") {
    if (modePompaManual) {
      if (message == "on") {
        digitalWrite(RELAY_PIN, HIGH);
        relay_ON = true;
      } else if (message == "off") {
        digitalWrite(RELAY_PIN, LOW);
        relay_ON = false;
      }
    }
  }

  else if (String(topic) == "hidroponik/batas/suhu") {
    StaticJsonDocument<128> doc;
    DeserializationError error = deserializeJson(doc, message);

    if (!error) {
      float suhuMin = doc["suhu_min"];
      float suhuMax = doc["suhu_max"];

      if (suhuMin >= 5.0 && suhuMax <= 60.0 && suhuMin < suhuMax) {
        BatasBawahSuhu = suhuMin;
        BatasAtasSuhu = suhuMax;
        Serial.print("Batas suhu diperbarui: ");
        Serial.print(BatasBawahSuhu);
        Serial.print(" - ");
        Serial.println(BatasAtasSuhu);
      } else {
        Serial.println("Format suhu tidak valid.");
      }
    } else {
      Serial.println("Gagal parsing JSON suhu.");
    }
  }

  else if (String(topic) == "hidroponik/batas/cahaya") {
    StaticJsonDocument<128> doc;
    DeserializationError error = deserializeJson(doc, message);

    if (!error) {
      int cahayaMin = doc["cahaya_min"];
      int cahayaMax = doc["cahaya_max"];

      if (cahayaMin > cahayaMax && cahayaMin <= 4095 && cahayaMax >= 0) {
        BatasBawahCahaya = cahayaMin;
        BatasAtasCahaya = cahayaMax;
        Serial.print("Batas cahaya diperbarui: ");
        Serial.print(BatasBawahCahaya);
        Serial.print(" - ");
        Serial.println(BatasAtasCahaya);
      } else {
        Serial.println("Format cahaya tidak valid.");
      }
    } else {
      Serial.println("Gagal parsing JSON cahaya.");
    }
  }
}

// MQTT Reconnect
void reconnect() {
  while (!client.connected()) {
    Serial.print("Menghubungkan ke MQTT...");
    // if (client.connect("ESP32HidroponikClient", mqtt_username, mqtt_password)) {
    if (client.connect("ESP32HidroponikClient")) {
      Serial.println("Berhasil!");
      client.subscribe(mqtt_topic_sub);
      client.subscribe("hidroponik/control/atap");
      client.subscribe("hidroponik/control/pompa");
      client.subscribe("hidroponik/batas/suhu");
      client.subscribe("hidroponik/batas/cahaya");
      client.subscribe("hidroponik/mode/atap");
      client.subscribe("hidroponik/mode/pompa");
    } else {
      Serial.print("Gagal, kode: ");
      Serial.println(client.state());
      delay(2000);
    }
  }
}

// void sendNotif(String notif) {
//   bool success = bot.sendMessage(CHAT_ID, notif, "");

//   if (success) {
//     Serial.println("Pesan terkirim!");
//   } else {
//     Serial.println("Gagal kirim pesan.");
//   }
// }

// Setup
void setup() {
  Serial.begin(115200);
  Serial.println("Booting...");
  pinMode(RELAY_PIN, OUTPUT);
  digitalWrite(RELAY_PIN, LOW);  // Pompa mati saat awal
  atap.attach(servoPin);
  atap2.attach(servoPin2);
  dht.begin();

  WiFi.begin(ssid, password);
  // espClient.setCACert(root_ca);
  // espClient.setCACert(TELEGRAM_CERTIFICATE_ROOT);
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println("\nWiFi Terhubung.");

  client.setServer(mqttserver, mqttPort);
  client.setCallback(callback);
  // Serial.println("Mengirim pesan ke Telegram...");
  // sendNotif("Tes send notif pertama kali");

}

// Loop
void loop() {
  if (!client.connected()) reconnect();
  client.loop();

  int nilaiCahaya = cahaya.baca();
  float nilaiSuhu = suhu.baca();

  Serial.print("Mode Pompa Manual: ");
  Serial.println(modePompaManual);
  if (!modeAtapManual) {
    cahaya.kontrolAtap(nilaiCahaya);
  }

  if (!modePompaManual) {
    suhu.kontrolPompa(nilaiSuhu);
  }

  // if (Serial.available()) {
  //   String input = Serial.readStringUntil('\n');
  //   input.trim();

  //   if (input == "manual-pompa") {
  //     modePompaManual = true;
  //     Serial.println("Mode pompa: MANUAL");
  //   } else if (input == "otomatis-pompa") {
  //     modePompaManual = false;
  //     Serial.println("Mode pompa: OTOMATIS");
  //   } else if (input == "on" && modePompaManual) {
  //     digitalWrite(RELAY_PIN, HIGH);
  //     relay_ON = true;
  //     Serial.println("Pompa dinyalakan secara manual");
  //   } else if (input == "off" && modePompaManual) {
  //     digitalWrite(RELAY_PIN, LOW);
  //     relay_ON = false;
  //     Serial.println("Pompa dimatikan secara manual");
  //   } else {
  //     Serial.println("Perintah tidak dikenal atau mode tidak sesuai");
  //   }
  // }

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
    "\"cahaya\": " + String(nilaiCahaya) +
    ", \"suhu\": " + String(nilaiSuhu) +
    ", \"relay\": " + (relay_ON ? "true" : "false") +
    ", \"atap\": " + (servo_ON ? "true" : "false") +
  "}";

  Serial.println(payload);

  client.publish(mqtt_topic_pub, payload.c_str());

  delay(2000);
}