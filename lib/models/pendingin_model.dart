import 'package:cloud_firestore/cloud_firestore.dart';

class PendinginModel {
  String? id;
  bool? pendingin_ON;
  String? id_suhu;
  Timestamp? updated_at;

  PendinginModel({this.id, this.pendingin_ON, this.id_suhu, this.updated_at});

  factory PendinginModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return PendinginModel(
      id: doc.id,
      pendingin_ON: data['pendingin_ON'] ?? false,
      id_suhu: data['id_suhu'] ?? '0',
      updated_at: data['updated_at'] as Timestamp? ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'pendingin_ON': pendingin_ON,
      'id_suhu': id_suhu,
      'updated_at': FieldValue.serverTimestamp(),
    };
  }
}
