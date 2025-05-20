import 'package:cloud_firestore/cloud_firestore.dart';

class BatasIntensitasCahayaModel {
  String? id;
  int? cahaya_max;
  int? cahaya_min;
  Timestamp? updated_at;

  BatasIntensitasCahayaModel({
    this.id,
    this.cahaya_max,
    this.cahaya_min,
    this.updated_at,
  });

  factory BatasIntensitasCahayaModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return BatasIntensitasCahayaModel(
      id: doc.id,
      cahaya_min: (data['cahaya_min'] as num?)?.toInt() ?? 123,
      cahaya_max: data['cahaya_max'] ?? 0,
      updated_at: data['updated_at'] as Timestamp? ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cahaya_max': cahaya_max,
      'cahaya_min': cahaya_min,
      'updated_at': FieldValue.serverTimestamp(),
    };
  }
}
