import 'package:cloud_firestore/cloud_firestore.dart';

class BatasSuhuModel {
  String? id;
  int? suhu_max;
  int? suhu_min;
  Timestamp? updated_at;

  BatasSuhuModel({this.id, this.suhu_max, this.suhu_min, this.updated_at});

  factory BatasSuhuModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return BatasSuhuModel(
      id: doc.id,
      suhu_max: data['suhu_max'] ?? 0,
      suhu_min: data['suhu_min'] ?? 0,
      updated_at: data['updated_at'] as Timestamp? ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'suhu_max': suhu_max,
      'suhu_min': suhu_min,
      'updated_at': FieldValue.serverTimestamp(),
    };
  }
}
