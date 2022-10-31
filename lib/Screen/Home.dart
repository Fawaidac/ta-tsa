import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:android_intent_plus/android_intent.dart';
import 'package:ta_tsa/Screen/Login.dart';
import 'package:ta_tsa/Shared/shared.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  // Position _myPosition = Position(
  //     longitude: 0,
  //     latitude: 0,
  //     timestamp: DateTime.now(),
  //     accuracy: 0,
  //     altitude: 0.0,
  //     heading: 0.0,
  //     speed: 0.0,
  //     speedAccuracy: 0.0);

  var locationMessage = "";
  void getCurrentLocation() async {
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var lastPosition = await Geolocator.getLastKnownPosition();
    print(lastPosition);
    var lat = position.latitude;
    var long = position.longitude;
    print("$lat,$long");
    setState(() {
      locationMessage = "Latitude : $lat , Longitude : $long";
    });
  }

  //getLongLAT
  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    //location service not enabled, don't continue
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location service Not Enabled');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permission denied');
      }
    }

    //permission denied forever
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Location permission denied forever, we cannot access',
      );
    }
    //continue accessing the position of device
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  // //getAddress
  Future<void> getAddressFromLongLat(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    setState(() {
      address =
          '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    });
  }

  // final _user = FirebaseAuth.instance.currentUser!;
  final cari = TextEditingController();
  // int _counter = 0;
  String location = 'lat: long:';
  String address = 'Mencari lokasi...';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lokasi"),
        backgroundColor: redColor,
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: SafeArea(
          child: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Poin Koordinat',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                location,
                style: const TextStyle(
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              const Text(
                'Address',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                // child: Text("$_myPosition"),
                child: Text("Position : $locationMessage"),
                // child: Text('${address}'),
              ),
              ElevatedButton(
                onPressed: () async {
                  getCurrentLocation();
                  // _determinePosition();
                  // Position position = await _getGeoLocationPosition();
                  // setState(() {
                  //   location =
                  //       'lat:${position.latitude}, long:${position.longitude}';
                  // });
                  // getAddressFromLongLat(position);
                },
                child: const Text('Cek Koordinat'),
                style: ElevatedButton.styleFrom(
                    shape: new RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
              SizedBox(
                height: 20,
              ),
              const Text(
                'Tujuan',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextFormField(
                  autofocus: false,
                  controller: cari,
                  decoration: InputDecoration(
                      hintText: "Search",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: () async {
                  final intent = AndroidIntent(
                      action: 'action_view',
                      data: Uri.encodeFull(
                          'google.navigation:q=${cari.text.trim()}'),
                      package: 'com.google.android.apps.maps');
                  await intent.launch();
                },
                child: const Text("Cari Lokasi"),
                style: ElevatedButton.styleFrom(
                    shape: new RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: ElevatedButton(
                  onPressed: () {
                    _signOut().then(
                      (value) => Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => Login(),
                        ),
                      ),
                    );
                  },
                  child: Text('Log Out'),
                  style: ElevatedButton.styleFrom(
                      shape: new RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }

//   Future<void> _determinePosition() async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       return Future.error('Location services belum aktif.');
//     }

//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         return Future.error('Location permissions ditolak');
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       // Permissions are denied forever, handle appropriately.
//       return Future.error(
//           'Location permissions ditolak, gagal request permissions.');
//     }

//     // When we reach here, permissions are granted and we can
//     // continue accessing the position of the device.
//     // return await Geolocator.getCurrentPosition();
//     Position myPosition = await Geolocator.getCurrentPosition();
//     setState(() => _myPosition = myPosition);
//   }
// }
}
