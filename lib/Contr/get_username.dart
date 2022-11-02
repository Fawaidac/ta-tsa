import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ta_tsa/Shared/shared.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GetUserName extends StatelessWidget {
  final String documentId;
  GetUserName({required this.documentId});
  TextEditingController password = TextEditingController();
  TextEditingController nama = TextEditingController();
  TextEditingController telepon = TextEditingController();
  final firebase = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    if (auth.currentUser != null) {
      print(auth.currentUser!.email);
    }
    //getcollection
    CollectionReference Users = FirebaseFirestore.instance.collection('Users');
    return FutureBuilder<DocumentSnapshot>(
        future: Users.doc(documentId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Container(
              padding: EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      'Nama : ${data['nama']}' +
                          ', ' +
                          'Email : ${data['email']}' +
                          ', ' +
                          'Telepon : ${data['telepon']}' +
                          ', ' +
                          'Password : ${data['password']}',
                      style: whiteTextStyle.copyWith(color: blackColor),
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        height: 30,
                        width: 30,
                        child: FloatingActionButton(
                            backgroundColor: Colors.green,
                            child: Center(
                                child: Icon(
                              Icons.edit,
                              color: Colors.white,
                            )),
                            onPressed: () {}),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      SizedBox(
                        height: 30,
                        width: 30,
                        child: FloatingActionButton(
                            backgroundColor: Colors.red,
                            child: Center(
                                child: Icon(
                              Icons.delete,
                              color: Colors.white,
                            )),
                            onPressed: () {}),
                      ),
                    ],
                  )
                ],
              ),
            );
            // Row(
            //   children: [
            //     SizedBox(
            //       child: FloatingActionButton(
            //           backgroundColor: Colors.green,
            //           child: Center(
            //               child: Icon(
            //             Icons.arrow_upward,
            //             color: Colors.white,
            //           )),
            //           onPressed: () {}),
            //     ),
            //     SizedBox(
            //       child: FloatingActionButton(
            //           backgroundColor: Colors.red,
            //           child: Center(
            //               child: Icon(
            //             Icons.delete,
            //             color: Colors.white,
            //           )),
            //           onPressed: () {}),
            //     ),
            //   ],
            // )

          }
          return Text('loading...');
        });
  }
}
