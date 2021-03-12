import 'package:flutter/material.dart';
import 'home.dart';
import 'Login.dart';
import 'main.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'authentication_service.dart';
import 'package:provider/provider.dart';

class Details extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DetailsState();
  }
}

class _DetailsState extends State<Details> {
  final TextEditingController Name = TextEditingController();
  final TextEditingController Phone = TextEditingController();
  final TextEditingController Age = TextEditingController();

  var firebaseUser = FirebaseAuth.instance.currentUser;
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.fromLTRB(13, 13, 13, 13),
            child: Center(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.fromLTRB(20, 40, 20, 40),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(18)),
                  ),
                  alignment: Alignment.center,
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Enter Details",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 33,
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        SizedBox(
                            height: 50.0,
                            child: TextFormField(
                                controller: Name,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: const BorderRadius.all(
                                      const Radius.circular(10.0),
                                    ),
                                  ),
                                  hintText: 'Full Name',
                                  filled: true,
                                  fillColor: new Color.fromRGBO(0, 0, 0, 240.0),
                                  contentPadding: const EdgeInsets.only(
                                      left: 14.0, bottom: 8.0, top: 8.0),
                                ))),
                        SizedBox(
                          height: 18,
                        ),
                        SizedBox(
                            height: 50.0,
                            child: TextFormField(
                                controller: Age,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: const BorderRadius.all(
                                      const Radius.circular(10.0),
                                    ),
                                  ),
                                  hintText: 'Age',
                                  filled: true,
                                  fillColor: new Color.fromRGBO(0, 0, 0, 240.0),
                                  contentPadding: const EdgeInsets.only(
                                      left: 14.0, bottom: 8.0, top: 8.0),
                                ))),
                        SizedBox(
                          height: 18,
                        ),
                        SizedBox(
                            height: 50.0,
                            child: TextFormField(
                                controller: Phone,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: const BorderRadius.all(
                                      const Radius.circular(10.0),
                                    ),
                                  ),
                                  hintText: 'Phone Number',
                                  filled: true,
                                  fillColor: new Color.fromRGBO(0, 0, 0, 240.0),
                                  contentPadding: const EdgeInsets.only(
                                      left: 14.0, bottom: 8.0, top: 8.0),
                                ))),
                        SizedBox(
                          height: 33,
                        ),
                        InkWell(
                          onTap: () => {
                            senddata(Name.text.trim(), Phone.text.trim(),
                                Age.text.trim()),
                          },
                          child: Container(
                            height: 33,
                            width: 99,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Center(
                              child: Text("Submit",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> senddata(String a, String b, String c) {
    final firestoreInstance = FirebaseFirestore.instance;
    var firebaseUser = FirebaseAuth.instance.currentUser;
    if (a != "" || b != "" || c != "") {
      firestoreInstance
          .collection("users")
          .doc(firebaseUser.uid)
          .set({
            "name": a,
            "phone": b,
            "Age": c,
            "status": "Waiting for confirmation",
            "driver name": "Not Assigned",
            "driver phone": "Not Assigned",
            "hospital": "Not Assigned"
          }, SetOptions(merge: true))
          .then((_) {})
          .whenComplete(() => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Home1()),
              ));
      Fluttertoast.showToast(
        msg: "Registration  Successful ",
      );
    } else {
      Fluttertoast.showToast(
        msg: "Enter all details",
      );
    }
  }
}
