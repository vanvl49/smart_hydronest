import 'package:smart_hydronest/models/penutup_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PenutupService {
  final CollectionReference penutupRef = FirebaseFirestore.instance.collection(
    'penutup',
  );

  Future<PenutupModel?> getPenutup() async {
    try {
      final snapshot = await penutupRef.limit(1).get();
      if (snapshot.docs.isNotEmpty) {
        return PenutupModel.fromFirestore(snapshot.docs.first);
      } else {
        print("Dokumen penutup tidak ditemukan.");
        return null;
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

  Future<void> updatePenutup(PenutupModel penutup) async {
    if (penutup.id == null) return;
    await penutupRef.doc(penutup.id).update(penutup.toJson());
  }
}
