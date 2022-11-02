import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ta_tsa/Screen/Dashboard.dart';

class SettingPage extends StatefulWidget {
  final String? docId;
  const SettingPage({Key? key, required this.docId}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  // controllers
  final _usernameController = TextEditingController();
  final _namaController = TextEditingController();
  final _telpController = TextEditingController();
  var db = FirebaseFirestore.instance;

  @override
  void initState() {
    _getUsername();
  }

  // getUser
  _getUsername() async {
    final docRef = db.collection("users").doc(widget.docId);
    docRef.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        setState(() {
          _usernameController.text = data["username"];
          _namaController.text = data["nama"];
          _telpController.text = data["no_telp"];
        });
      },
      onError: (e) => print("Error getting document: $e"),
    );
  }

  _updateInfo() {
    final user = <String, dynamic>{
      "username": _usernameController.text.trim(),
      "nama": _namaController.text,
      "no_telp": _telpController.text.trim()
    };
    final users = db.collection("users").doc(widget.docId);
    users.update(user).then((value) {
      Get.snackbar("Update Berhasil", "DocumentSnapshot successfully updated!");
      Get.off(Dashboard());
    }, onError: (e) {
      Get.snackbar("Update Gagal", "Error updating document $e!");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF4E9F3D),
        title: Text("Profile Setting"),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // const Icon(
                //   Icons.android_outlined,
                //   size: 100,
                // ),
                // text di atas
                Container(
                  height: 260,
                  width: 260,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://avatars.githubusercontent.com/u/12584890?v=4"),
                  ),
                ),

                // sized box cuma buat margin, idk any alternatives
                const SizedBox(
                  height: 10,
                ),

                // ini input text atau form
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: TextField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Username',
                    ),
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),

                // ini input text atau form
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: TextField(
                    controller: _namaController,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Nama',
                    ),
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),

                // ini input text atau form
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: TextField(
                    controller: _telpController,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'No Telpon',
                    ),
                  ),
                ),

                //
                const SizedBox(
                  height: 10,
                ),
                //
                // ini input text atau form
                //
                const SizedBox(
                  height: 30,
                ),
                //

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF4E9F3D)),
                        onPressed: _updateInfo,
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            "Update",
                            style: TextStyle(fontSize: 24),
                          ),
                        )),
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
