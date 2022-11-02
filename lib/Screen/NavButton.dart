import 'package:flutter/material.dart';
import 'package:ta_tsa/Screen/Dashboard.dart';
import 'package:ta_tsa/Screen/Location.dart';
import 'package:ta_tsa/Screen/Profile.dart';
import 'package:ta_tsa/Shared/shared.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key}) : super();

  @override
  State<NavBar> createState() => _NavBar();
}

class _NavBar extends State<NavBar> {
  int currentTab = 0;
  static final List<Widget> screen = <Widget>[
    Dashboard(),
    MyLocation(),
    Profile()
  ];
  void onTap(int index) {
    setState(() {
      currentTab = index;
      currentScreen = Dashboard();
    });
  }

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = Dashboard();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(bucket: bucket, child: screen.elementAt(currentTab)),
      bottomNavigationBar: BottomNavigationBar(
          iconSize: 30,
          selectedFontSize: 12,
          unselectedFontSize: 0,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          onTap: onTap,
          currentIndex: currentTab,
          selectedItemColor: blueColor,
          unselectedItemColor: blackColor,
          showSelectedLabels: true,
          showUnselectedLabels: false,
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
                label: "Dashboard",
                icon: Icon(Icons.dashboard_customize_outlined),
                activeIcon: Icon(Icons.dashboard_customize)),
            BottomNavigationBarItem(
                label: "Lokasi",
                icon: Icon(Icons.location_on_outlined),
                activeIcon: Icon(Icons.location_on)),
            BottomNavigationBarItem(
                label: "Profil",
                icon: Icon(Icons.person_outline),
                activeIcon: Icon(Icons.person)),
          ]),
    );
  }
}
