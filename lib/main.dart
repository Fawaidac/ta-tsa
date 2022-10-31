import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ta_tsa/Screen/Home.dart';
import 'package:ta_tsa/Screen/Login.dart';
import 'package:ta_tsa/Shared/shared.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: Colors.red,
            primaryColor: Colors.red,
            scaffoldBackgroundColor: Colors.white,
            textTheme:
                Theme.of(context).textTheme.apply(displayColor: blackColor)),
        home: Wellcome());
  }
}

class Wellcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(50, 100, 50, 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
            ),
            Text(
              "Wellcome to my applications",
              style: whiteTextStyle.copyWith(
                  fontSize: 32, color: redColor, fontWeight: FontWeight.bold),
            ),
            Spacer(),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Login()));
                },
                label: Text("Get Started", style: whiteTextStyle),
                icon: Icon(Icons.arrow_right_alt_outlined),
                style: ElevatedButton.styleFrom(
                    backgroundColor: redColor,
                    shape: new RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
            )
          ],
        ),
      ),
    );
  }
}
