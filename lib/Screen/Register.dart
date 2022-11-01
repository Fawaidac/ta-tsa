import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ta_tsa/Screen/Login.dart';
import 'package:ta_tsa/Shared/shared.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController namaController = TextEditingController();
  TextEditingController teleponController = TextEditingController();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future registerSubmit() async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: emailController.text.toString().trim(),
          password: passwordController.text.toString().trim());

      addUserDetails(emailController.text.trim(), namaController.text.trim(),
          teleponController.text.trim(), passwordController.text.trim());
    } catch (e) {
      const snackBar = SnackBar(
        content: Text('Format Username atau Password salah!'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    namaController.dispose();
    teleponController.dispose();
    super.dispose();
  }

  Future addUserDetails(
      String email, String namalengkap, String telepon, String password) async {
    await _firestore.collection('Users').add({
      'email': email,
      'nama lengkap': namalengkap,
      'telepon': telepon,
      'password': password,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [blueColor, Colors.lightBlue, Colors.lightBlueAccent],
        )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Register",
              style: whiteTextStyle.copyWith(
                  fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextField(
                        textInputAction: TextInputAction.next,
                        controller: emailController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "E-mail",
                        ),
                      ),
                    ])),
            const SizedBox(
              height: 10,
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextField(
                        textInputAction: TextInputAction.next,
                        controller: namaController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Nama Lengkap",
                        ),
                      ),
                    ])),
            const SizedBox(
              height: 10,
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextField(
                        textInputAction: TextInputAction.next,
                        controller: teleponController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Telepon",
                        ),
                      ),
                    ])),
            const SizedBox(
              height: 10,
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextField(
                        textInputAction: TextInputAction.done,
                        obscureText: true,
                        controller: passwordController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Password",
                        ),
                      ),
                    ])),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  registerSubmit();
                },
                label: Text("Register",
                    style: whiteTextStyle.copyWith(color: blackColor)),
                icon: Icon(
                  Icons.keyboard_arrow_right_outlined,
                  color: blackColor,
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: whiteColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Sudah memiliki akun ?",
                    style: whiteTextStyle.copyWith(
                        color: blackColor, fontSize: 14),
                  ),
                  TextButton(
                    child: Text(
                      "Login",
                      style: whiteTextStyle.copyWith(
                          color: whiteColor, fontSize: 14),
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Login()));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
