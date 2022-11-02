import 'package:flutter/material.dart';
import 'package:ta_tsa/Contr/UserModel.dart';
import 'package:ta_tsa/Contr/firestore_helper.dart';
import '';

class EditPage extends StatefulWidget {
  final UserModel user;
  const EditPage({Key? key, required this.user}) : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  TextEditingController? passwordController;
  TextEditingController? namaController;
  TextEditingController? telpController;

  @override
  void initState() {
    namaController = TextEditingController(text: widget.user.nama);
    telpController = TextEditingController(text: widget.user.telepon);
    passwordController = TextEditingController(text: widget.user.password);
    super.initState();
  }

  @override
  void dispose() {
    namaController!.dispose();
    passwordController!.dispose();
    telpController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Edit"),
        ),
        body: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              TextFormField(
                controller: namaController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: "nama"),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: "password"),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: telpController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: "password"),
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  FirestoreHelper.update(
                    UserModel(
                        nama: namaController!.text,
                        password: passwordController!.text,
                        telepon: telpController!.text),
                  ).then((value) {
                    Navigator.pop(context);
                  });
                },
                child: Container(
                  width: 100,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.green,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Update",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
