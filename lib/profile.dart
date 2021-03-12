import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'authentication_service.dart';
import 'package:ambbook/Login.dart';

import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class profile extends StatelessWidget {
  var firebaseUser = FirebaseAuth.instance.currentUser;
  final firestoreInstance = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            toolbarHeight: 70,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(20),
              ),
            ),
            backgroundColor: Colors.black,
            leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                color: Colors.white,
                onPressed: () {
                  Navigator.pop(context);
                }),
          ),
          body: Container(
              child: StreamBuilder(
                  stream: firestoreInstance
                      .collection("users")
                      .doc(firebaseUser.uid)
                      .snapshots(),
                  builder: (context1, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Center(
                            child: SpinKitFadingCircle(
                          color: Colors.black,
                          duration: const Duration(milliseconds: 2000),
                        ));
                      //CircularProgressIndicator();

                      default:
                        return Container(
                            padding: EdgeInsets.all(5),
                            alignment: Alignment.center,
                            child: Container(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "Profile".toUpperCase(),
                                    textScaleFactor: 1.5,
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                  Divider(
                                    color: Colors.grey,
                                    height: 20.0,
                                  ),
                                  Container(
                                      padding:
                                          EdgeInsets.fromLTRB(30, 20, 30, 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Name".toUpperCase(),
                                            textScaleFactor: 1,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            snapshot.data["name"]
                                                .toString()
                                                .toUpperCase(),
                                            textScaleFactor: 1,
                                          ),
                                        ],
                                      )),
                                  Container(
                                      padding:
                                          EdgeInsets.fromLTRB(30, 20, 30, 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Phone".toUpperCase(),
                                            textScaleFactor: 1,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            snapshot.data["phone"]
                                                .toString()
                                                .toUpperCase(),
                                            textScaleFactor: 1,
                                          ),
                                        ],
                                      )),
                                  Container(
                                      padding:
                                          EdgeInsets.fromLTRB(30, 20, 30, 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Age".toUpperCase(),
                                            textScaleFactor: 1,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            snapshot.data["Age"]
                                                .toString()
                                                .toUpperCase(),
                                            textScaleFactor: 1,
                                          )
                                        ],
                                      )),
                                  Container(
                                      padding:
                                          EdgeInsets.fromLTRB(30, 20, 30, 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Email".toUpperCase(),
                                            textScaleFactor: 1,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(firebaseUser.email.toString()),
                                        ],
                                      )),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  SizedBox(
                                    height: 35,
                                  ),
                                  ButtonTheme(
                                    minWidth: 150.0,
                                    height: 40.0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        15.0,
                                      ),
                                    ),
                                    child: RaisedButton(
                                      onPressed: () => {
                                        context
                                            .read<AuthenticationService>()
                                            .signOut()
                                            .whenComplete(
                                              () => Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Login()),
                                              ),
                                            )
                                      },
                                      color: Colors.black,
                                      elevation: 4.0,
                                      child: Text(
                                        "Logout",
                                        textScaleFactor: 1,
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ));
                    }
                  }))),
    );
  }
}
