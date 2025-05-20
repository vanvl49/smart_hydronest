import 'package:smart_hydronest/models/batasSuhu_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BatasSuhuService {
  final CollectionReference batasSuhuRef = FirebaseFirestore.instance
      .collection('batas_suhu');

  Future<BatasSuhuModel?> getBatasSuhu() async {
    try {
      final snapshot = await batasSuhuRef.limit(1).get();
      if (snapshot.docs.isNotEmpty) {
        return BatasSuhuModel.fromFirestore(snapshot.docs.first);
      } else {
        print("Dokumen batas suhu tidak ditemukan.");
        return null;
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

  Future<void> updateBatasSuhu(BatasSuhuModel batas_suhu) async {
    if (batas_suhu.id == null) return;
    await batasSuhuRef.doc(batas_suhu.id).update(batas_suhu.toJson());
  }
}
