import 'package:smart_hydronest/models/suhu_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SuhuService {
  final CollectionReference suhuRef = FirebaseFirestore.instance.collection(
    'suhu',
  );

  Future<SuhuModel?> getSuhu() async {
    try {
      final snapshot =
          await suhuRef.orderBy('created_at', descending: true).limit(1).get();
      if (snapshot.docs.isNotEmpty) {
        return SuhuModel.fromFirestore(snapshot.docs.first);
      } else {
        print("Dokumen suhu tidak ditemukan.");
        return null;
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }
}
