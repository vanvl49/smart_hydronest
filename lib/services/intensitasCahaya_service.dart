import 'package:smart_hydronest/models/intensitasCahaya_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class IntensitasCahayaService {
  final CollectionReference intensitasCahayaRef = FirebaseFirestore.instance.collection(
    'intensitas_cahaya',
  );

  Future<IntensitasCahayaModel?> getIntensitasCahaya() async {
    try {
      final snapshot =
          await intensitasCahayaRef.orderBy('created_at', descending: true).limit(1).get();
      if (snapshot.docs.isNotEmpty) {
        return IntensitasCahayaModel.fromFirestore(snapshot.docs.first);
      } else {
        print("Dokumen intensitas cahaya tidak ditemukan.");
        return null;
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }
}
