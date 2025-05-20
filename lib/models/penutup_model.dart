import 'package:cloud_firestore/cloud_firestore.dart';

class PenutupModel {
  String? id;
  bool? penutup_ON;
  String? id_intensitas_cahaya;
  Timestamp? updated_at;

  PenutupModel({
    this.id,
    this.penutup_ON,
    this.id_intensitas_cahaya,
    this.updated_at,
  });

  factory PenutupModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return PenutupModel(
      id: doc.id,
      penutup_ON: data['penutup_ON'] ?? false,
      id_intensitas_cahaya: data['id_intensitas_cahaya'] ?? '0',
      updated_at: data['updated_at'] as Timestamp? ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'penutup_ON': penutup_ON,
      'id_intensitas_cahaya': id_intensitas_cahaya,
      'updated_at': FieldValue.serverTimestamp(),
    };
  }
}
