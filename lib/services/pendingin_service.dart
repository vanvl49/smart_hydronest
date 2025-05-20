import 'package:smart_hydronest/models/pendingin_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PendinginService {
  final CollectionReference pendinginRef = FirebaseFirestore.instance
      .collection('pendingin');

  Future<PendinginModel?> getPendingin() async {
    try {
      final snapshot = await pendinginRef.limit(1).get();
      if (snapshot.docs.isNotEmpty) {
        return PendinginModel.fromFirestore(snapshot.docs.first);
      } else {
        print("Dokumen pendingin tidak ditemukan.");
        return null;
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

  Future<void> updatePendingin(PendinginModel pendingin) async {
    if (pendingin.id == null) return;
    await pendinginRef.doc(pendingin.id).update(pendingin.toJson());
  }
}
