import 'package:cloud_firestore/cloud_firestore.dart';
import 'UserModel.dart';

class FirestoreHelper {
  static Stream<List<UserModel>> read() {
    final userCollection = FirebaseFirestore.instance.collection("Users");
    return userCollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList());
  }

  static Future create(UserModel user) async {
    final userCollection = FirebaseFirestore.instance.collection("Users");

    final docRof = userCollection.doc();

    final newUser = UserModel(
            nama: user.nama,
            email: user.email,
            telepon: user.telepon,
            password: user.password)
        .toJson();

    try {
      await docRof.set(newUser);
    } catch (e) {
      print("some error occured $e");
    }
  }

  static Future update(UserModel user) async {
    final userCollection = FirebaseFirestore.instance.collection("users");

    final docRef = userCollection.doc(user.id);

    final newUser = UserModel(
            id: user.id,
            nama: user.nama,
            email: user.email,
            telepon: user.telepon,
            password: user.password)
        .toJson();

    try {
      await docRef.update(newUser);
    } catch (e) {
      print("some error occured $e");
    }
  }

  static Future delete(UserModel user) async {
    final userCollection = FirebaseFirestore.instance.collection("users");

    final docRef = userCollection.doc(user.id).delete();
  }
}
