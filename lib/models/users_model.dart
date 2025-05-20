import 'package:cloud_firestore/cloud_firestore.dart';

class UsersModel {
  String? id;
  String? nama;
  String? username;
  String? password;
  String? foto;
  Timestamp? updated_at;

  UsersModel({
    this.id,
    this.nama,
    this.username,
    this.password,
    this.foto,
    this.updated_at,
  });

  factory UsersModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UsersModel(
      id: doc.id,
      nama: data['nama'] ?? 'no name',
      username: data['username'] ?? 'no username',
      password: data['password'] ?? 'no password',
      foto: data['foto'] ?? 'no foto',
      updated_at: data['updated_at'] ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': nama,
      'username': username,
      'password': password,
      'foto': foto,
      'updated_at': FieldValue.serverTimestamp(),
    };
  }
}
