import 'package:flutter/material.dart';
import 'package:ta_tsa/Shared/shared.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: blueColor,
        centerTitle: true,
        title: Text(
          'Dashboard',
          style: whiteTextStyle.copyWith(
              fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Selamat Datang wahai anak Muda",
              style: whiteTextStyle.copyWith(fontSize: 20, color: blackColor),
            )
          ],
        ),
      ),
    );
  }
}
