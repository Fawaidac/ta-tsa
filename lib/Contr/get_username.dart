import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ta_tsa/Shared/shared.dart';

class GetUserName extends StatelessWidget {
  final String documentId;
  GetUserName({required this.documentId});

  @override
  Widget build(BuildContext context) {
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
                  Text(
                    'Nama : ${data['nama lengkap']}' +
                        ', ' +
                        'Email : ${data['email']}' +
                        ', ' +
                        'Telepon : ${data['telepon']}' +
                        ', ' +
                        'Password : ${data['password']}',
                    style: whiteTextStyle.copyWith(color: blackColor),
                  ),
                  TextButton(child: Text("Edit"), onPressed: () {}),
                  TextButton(child: Text("Delete"), onPressed: () {}),
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
