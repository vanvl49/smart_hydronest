import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'package:smart_hydronest/models/suhu_model.dart';
import 'package:smart_hydronest/models/intensitasCahaya_model.dart';
import 'package:smart_hydronest/services/notifikasi_service.dart';

class MqttService {
  final client = MqttServerClient('broker.hivemq.com', '');
  DateTime? _lastSavedTime;

  void connect() async {
    client.port = 1883;
    client.keepAlivePeriod = 20;
    client.onDisconnected = () => print('MQTT disconnected');
    client.logging(on: false);

    final connMessage =
        MqttConnectMessage()
            .withClientIdentifier(
              'flutter_client_${DateTime.now().millisecondsSinceEpoch}',
            )
            .startClean();

    client.connectionMessage = connMessage;

    client.onConnected = () {
      print('✅ MQTT Connected');
      client.subscribe('hidroponik/mode/atap', MqttQos.atLeastOnce);
      client.subscribe('hidroponik/control/atap', MqttQos.atLeastOnce);
      client.subscribe('hidroponik/mode/pompa', MqttQos.atLeastOnce);
      client.subscribe('hidroponik/control/pompa', MqttQos.atLeastOnce);
      client.subscribe('hidroponik/batas/cahaya', MqttQos.atLeastOnce);
      client.subscribe('hidroponik/batas/suhu', MqttQos.atLeastOnce);
      client.subscribe('smart-hydronest/sensor-data', MqttQos.atLeastOnce);
    };

    try {
      await client.connect();
    } catch (e) {
      print('MQTT connect error: $e');
      await Future.delayed(Duration(seconds: 3));
      client.disconnect();
      return;
    }

    client.subscribe('smart-hydronest/sensor-data', MqttQos.atLeastOnce);

    client.updates?.listen((
      List<MqttReceivedMessage<MqttMessage>> messages,
    ) async {
      final recMess = messages[0].payload as MqttPublishMessage;
      final payload = MqttPublishPayload.bytesToStringAsString(
        recMess.payload.message,
      );
      final now = DateTime.now();

      if (_lastSavedTime == null ||
          now.difference(_lastSavedTime!) > Duration(seconds: 15)) {
        final data = jsonDecode(payload);

        FirebaseFirestore.instance
            .collection('suhu')
            .add(
              SuhuModel(
                suhu: (data['suhu'] as num).toInt(),
                id_batas_suhu: '1',
                created_at: Timestamp.now(),
              ).toJson(),
            );

        FirebaseFirestore.instance
            .collection('intensitas_cahaya')
            .add(
              IntensitasCahayaModel(
                intensitas_cahaya: (data['cahaya'] as num).toInt(),
                id_batas_intensitas_cahaya: '1',
                created_at: Timestamp.now(),
              ).toJson(),
            );

        await updateRelayDanPenutup(
          data['relay'] ?? false,
          data['atap'] ?? false,
        );

        _lastSavedTime = now;
      }
    });
  }

  void disconnect() {
    client.disconnect();
  }

  Future<void> safePublish(String topic, String message) async {
    if (client.connectionStatus?.state != MqttConnectionState.connected) {
      print("MQTT tidak terkoneksi. Mencoba reconnect...");
      connect();

      // Tunggu sejenak agar koneksi stabil
      await Future.delayed(Duration(seconds: 2));
    }

    if (client.connectionStatus?.state == MqttConnectionState.connected) {
      final builder = MqttClientPayloadBuilder();
      builder.addString(message);
      client.publishMessage(topic, MqttQos.atLeastOnce, builder.payload!);
      print("✅ Publish ke $topic berhasil: $message");
    } else {
      print("❌ Gagal publish meski sudah reconnect.");
    }
  }

  void kontrolPenutup(String perintah) async {
    await safePublish('hidroponik/mode/atap', 'manual');
    await safePublish('hidroponik/control/atap', perintah);

    // final modeBuilder = MqttClientPayloadBuilder();
    // modeBuilder.addString('manual');

    // client.publishMessage(
    //   'hidroponik/mode/atap',
    //   MqttQos.atLeastOnce,
    //   modeBuilder.payload!,
    // );

    // final perintahBuilder = MqttClientPayloadBuilder();
    // perintahBuilder.addString(perintah);

    // client.publishMessage(
    //   'hidroponik/control/atap',
    //   MqttQos.atLeastOnce,
    //   perintahBuilder.payload!,
    // );
  }

  void kontrolPendingin(String perintah) async {
    await safePublish('hidroponik/mode/pompa', 'manual');
    await safePublish('hidroponik/control/pompa', perintah);

    // final modeBuilder = MqttClientPayloadBuilder();
    // modeBuilder.addString('manual');

    // client.publishMessage(
    //   'hidroponik/mode/pompa',
    //   MqttQos.atLeastOnce,
    //   modeBuilder.payload!,
    // );

    // final perintahBuilder = MqttClientPayloadBuilder();
    // perintahBuilder.addString(perintah);

    // client.publishMessage(
    //   'hidroponik/control/pompa',
    //   MqttQos.atLeastOnce,
    //   perintahBuilder.payload!,
    // );
  }

  void ubahBatasSuhu() {
    FirebaseFirestore.instance
        .collection('batas_suhu')
        .limit(1)
        .snapshots()
        .listen((snapshot) {
          if (snapshot.docs.isNotEmpty) {
            final data = snapshot.docs.first.data();
            final suhuMin = data['suhu_min'];
            final suhuMax = data['suhu_max'];

            final payload = jsonEncode({
              'suhu_min': suhuMin,
              'suhu_max': suhuMax,
            });

            safePublish('hidroponik/batas/suhu', payload);
            print("📤 Publish batas suhu ke MQTT: $payload");
          }
        });
  }

  void ubahBatasCahaya() {
    FirebaseFirestore.instance
        .collection('batas_intensitas_cahaya')
        .limit(1)
        .snapshots()
        .listen((snapshot) {
          if (snapshot.docs.isNotEmpty) {
            final data = snapshot.docs.first.data();
            final cahayaMin = data['cahaya_min'];
            final cahayaMax = data['cahaya_max'];

            final payload = jsonEncode({
              'cahaya_min': cahayaMin,
              'cahaya_max': cahayaMax,
            });

            safePublish('hidroponik/batas/cahaya', payload);
            print("📤 Publish batas cahaya ke MQTT: $payload");
          }
        });
  }

  Future<void> updateRelayDanPenutup(bool relay, bool atap) async {
    final firestore = FirebaseFirestore.instance;

    final pendinginSnapshot =
        await firestore.collection('pendingin').limit(1).get();
    if (pendinginSnapshot.docs.isNotEmpty) {
      final doc = pendinginSnapshot.docs.first;
      await doc.reference.update({
        'pendingin_ON': relay,
        'updated_at': Timestamp.now(),
      });
    }

    final penutupSnapshot =
        await firestore.collection('penutup').limit(1).get();
    if (penutupSnapshot.docs.isNotEmpty) {
      final doc = penutupSnapshot.docs.first;
      await doc.reference.update({
        'penutup_ON': atap,
        'updated_at': Timestamp.now(),
      });
    }
  }
}
