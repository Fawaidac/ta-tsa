import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ta_tsa/Screen/Home.dart';
import 'package:ta_tsa/Screen/Register.dart';
import 'package:ta_tsa/Shared/shared.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future _loginSubmit() async {
    try {
      _firebaseAuth
          .signInWithEmailAndPassword(
              email: emailController.text, password: passwordController.text)
          .then(
            (value) => Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => Home(),
              ),
            ),
          );
      // await FirebaseAuth.instance.signInWithEmailAndPassword(
      //     email: emailController.text.trim(),
      //     password: passwordController.text.trim());
    } catch (e) {
      // print(e);
      // SnackBar(content: Text(e.toString()));
      const snackBar = SnackBar(
        content: Text('Password dan username salah!'),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   emailController.dispose();
  //   passwordController.dispose();
  //   super.dispose();
  // }

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
          colors: [redColor, whiteColor],
        )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "LOGIN",
              style: whiteTextStyle.copyWith(
                  fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(
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
            SizedBox(
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
            SizedBox(
              height: 20,
            ),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  _loginSubmit();
                },
                label: Text("Login kids", style: whiteTextStyle),
                icon: Icon(Icons.keyboard_arrow_right_outlined),
                style: ElevatedButton.styleFrom(
                    backgroundColor: redColor,
                    shape: new RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Belum memiliki akun ?",
                    style: whiteTextStyle.copyWith(
                        color: blackColor, fontSize: 14),
                  ),
                  TextButton(
                    child: Text(
                      "Register",
                      style: whiteTextStyle.copyWith(
                          color: redColor, fontSize: 14),
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Register()));
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
