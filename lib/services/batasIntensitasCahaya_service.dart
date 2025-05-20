import 'package:smart_hydronest/models/batasIntensitasCahaya_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BatasIntensitasCahayaService {
  final CollectionReference batasIntensitasCahayaRef = FirebaseFirestore
      .instance
      .collection('batas_intensitas_cahaya');

  Future<BatasIntensitasCahayaModel?> getBatasCahaya() async {
    try {
      final snapshot = await batasIntensitasCahayaRef.limit(1).get();
      if (snapshot.docs.isNotEmpty) {
        print(BatasIntensitasCahayaModel.fromFirestore(snapshot.docs.first));
        return BatasIntensitasCahayaModel.fromFirestore(snapshot.docs.first);
      } else {
        print("Dokumen batas intensitas cahaya tidak ditemukan.");
        return null;
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

  Future<void> updateBatasCahaya(
    BatasIntensitasCahayaModel batas_cahaya,
  ) async {
    if (batas_cahaya.id == null) return;
    await batasIntensitasCahayaRef
        .doc(batas_cahaya.id)
        .update(batas_cahaya.toJson());
  }
}
