import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ta_tsa/Contr/get_username.dart';
import 'package:ta_tsa/Contr/item_card.dart';
import 'package:ta_tsa/Screen/Login.dart';
import 'package:ta_tsa/Shared/shared.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  //read
  List<String> docIDs = [];

  //get docIDs
  Future getDocId() async {
    await FirebaseFirestore.instance.collection('Users').get().then(
          (snapshot) => snapshot.docs.forEach(
            (document) {
              print(document.reference);
              docIDs.add(document.reference.id);
            },
          ),
        );
  }

  @override
  void initState() {
    getDocId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('Users');

    FirebaseAuth auth = FirebaseAuth.instance;
    if (auth.currentUser != null) {
      print(auth.currentUser!.email);
    }
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: blueColor,
            centerTitle: true,
            title: Text(
              '${auth.currentUser!.email}',
              style: whiteTextStyle.copyWith(
                  fontSize: 20, fontWeight: FontWeight.bold),
            ),
            actions: [
              IconButton(
                  icon: Icon(Icons.logout),
                  onPressed: () {
                    _signOut().then(
                      (value) => Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const Login(),
                        ),
                      ),
                    );
                  }),
            ]),
        body: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Text(
                //   '${auth.currentUser!.email}',
                //   style: whiteTextStyle.copyWith(
                //       fontSize: 16,
                //       fontWeight: FontWeight.bold,
                //       color: blackColor),
                // ),
                // SizedBox(
                //   height: 20,
                // ),
                Expanded(
                  child: FutureBuilder(
                      future: getDocId(),
                      builder: (context, snapshot) {
                        return ListView.builder(
                            itemCount: docIDs.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  title: GetUserName(documentId: docIDs[index]),
                                  tileColor: Colors.grey.shade200,
                                ),
                              );
                            });
                      }),
                ),
              ],
            ),
          ),
        ));
  }
}
