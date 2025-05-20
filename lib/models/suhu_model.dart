import 'package:cloud_firestore/cloud_firestore.dart';

class SuhuModel {
  String? id;
  int? suhu;
  String? id_batas_suhu;
  Timestamp? created_at;

  SuhuModel({this.id, this.suhu, this.id_batas_suhu, this.created_at});

  factory SuhuModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return SuhuModel(
      id: doc.id,
      suhu: data['suhu'] ?? 0,
      id_batas_suhu: data['id_batas_suhu'] ?? '0',
      created_at: data['created_at'] as Timestamp? ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'suhu': suhu,
      'id_batas_suhu': id_batas_suhu,
      'created_at': FieldValue.serverTimestamp(),
    };
  }
}
