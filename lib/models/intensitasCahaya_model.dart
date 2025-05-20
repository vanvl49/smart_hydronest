import 'package:cloud_firestore/cloud_firestore.dart';

class IntensitasCahayaModel {
  String? id;
  int? intensitas_cahaya;
  String? id_batas_intensitas_cahaya;
  Timestamp? created_at;

  IntensitasCahayaModel({
    this.id,
    this.intensitas_cahaya,
    this.id_batas_intensitas_cahaya,
    this.created_at,
  });

  factory IntensitasCahayaModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return IntensitasCahayaModel(
      id: doc.id,
      intensitas_cahaya: data['intensitas_cahaya'] ?? 0,
      id_batas_intensitas_cahaya: data['id_batas_intensitas_cahaya'] ?? '0',
      created_at: data['created_at'] as Timestamp? ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'intensitas_cahaya': intensitas_cahaya,
      'id_batas_intensitas_cahaya': id_batas_intensitas_cahaya,
      'created_at': FieldValue.serverTimestamp(),
    };
  }
}
