import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String? nama;
  final String? email;
  final String? telepon;
  final String? password;

  UserModel(
      {required this.nama,
      this.email,
      required this.telepon,
      required this.password,
      this.id});

  factory UserModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return UserModel(
        id: snapshot['id'],
        nama: snapshot['nama'],
        email: snapshot['email'],
        telepon: snapshot['telepon'],
        password: snapshot['password']);
  }

  get age => null;
  Map<String, dynamic> toJson() => {
        "nama": nama,
        "email": email,
        "telepon": telepon,
        "password": password,
        "id": id,
      };
}
