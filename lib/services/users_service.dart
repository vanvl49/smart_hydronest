import 'package:smart_hydronest/models/users_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UsersService {
  final CollectionReference usersRef = FirebaseFirestore.instance.collection(
    'users',
  );

  Future<UsersModel?> getUsers() async {
    try {
      final snapshot = await usersRef.limit(1).get();
      if (snapshot.docs.isNotEmpty) {
        return UsersModel.fromFirestore(snapshot.docs.first);
      } else {
        print("Dokumen users tidak ditemukan.");
        return null;
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

  Future<UsersModel?> getUsersById(String id) async {
    final doc = await usersRef.doc(id).get();
    if (doc.exists) {
      return UsersModel.fromFirestore(doc);
    }
    return null;
  }

  Future<UsersModel?> getUsersByUsername(String username) async {
    final querySnapshot =
        await usersRef.where('username', isEqualTo: username).get();

    if (querySnapshot.docs.isNotEmpty) {
      final doc = querySnapshot.docs.first;
      return UsersModel.fromFirestore(doc);
    }

    return null;
  }

  Future<void> updateUsers(UsersModel user) async {
    if (user.id == null) return;
    await usersRef.doc(user.id).update(user.toJson());
  }
}
