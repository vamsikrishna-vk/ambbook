import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission/permission.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'authentication_service.dart';
import 'package:provider/provider.dart';
import 'package:ambbook/profile.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location_permissions/location_permissions.dart';
//import 'package:location/location.dart';

class Home1 extends StatelessWidget {
  final firestoreInstance = FirebaseFirestore.instance;
  var firebaseUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: new Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  _HomeState() {
    locationtrack();
  }
  @override
  final Geolocator geolocator = Geolocator();
  final firestoreInstance = FirebaseFirestore.instance;
  var firebaseUser = FirebaseAuth.instance.currentUser;
  GoogleMapController _controller;

  static const LatLng _center = const LatLng(13.115415, 77.6367932);
  //Location _location = Location();
  Position _currentPosition;
  Future locationtrack() async {
    _currentPosition = await Geolocator.getCurrentPosition();
    print(_currentPosition);
  }

  void _onMapCreated(GoogleMapController _cntlr) {
    _controller = _cntlr;

    CameraPosition(
        target: LatLng(_currentPosition.latitude, _currentPosition.longitude),
        zoom: 11);
  }

  bool emergency = false;
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            toolbarHeight: 70,
            backgroundColor: Colors.black,
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: Icon(
                    Icons.menu,
                    size: 30,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  tooltip:
                      MaterialLocalizations.of(context).openAppDrawerTooltip,
                );
              },
            ),
          ),
          drawer: Drawer(
              child: Container(
                  child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                padding: EdgeInsets.fromLTRB(10, 50, 10, 50),
                curve: Curves.fastLinearToSlowEaseIn,
                child: Text(
                  "Ambbook".toString().toUpperCase(),
                  textScaleFactor: 1.7,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                decoration: BoxDecoration(
                  color: Colors.black,
                ),
              ),
              ListTile(
                title: Text(
                  "Profile",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 18),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => profile()),
                  );
                },
                trailing: Icon(Icons.arrow_forward_ios, color: Colors.black),
              ),
            ],
          ))),
          body: SafeArea(
              child: Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      if (!emergency)
                        (Container(
                          decoration: new BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          height: 400,
                          child: GoogleMap(
                            onMapCreated: _onMapCreated,
                            initialCameraPosition:
                                CameraPosition(target: _center, zoom: 15),
                            mapType: MapType.normal,
                            myLocationEnabled: true,
                          ),
                        )),
                      SizedBox(
                        height: 30,
                      ),
                      if (!emergency)
                        (InkWell(
                            onTap: () => {_showDialog(context)},
                            child: Container(
                                height: 60,
                                decoration: new BoxDecoration(
                                  color: Colors.red,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                ),
                                child: Center(
                                  child: Text(
                                    "Book Ambulance".toUpperCase(),
                                    textScaleFactor: 1.5,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )))),
                      if (emergency)
                        (Center(
                            child: Container(
                                child: Column(
                          children: [Text("Your Ambulance is on its way",
                          textScaleFactor: 1.5,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),)],
                        ))))
                    ],
                  )))),
    );
  }

  void _showDialog(BuildContext context) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(
              "Are you sure you want to book ambulance to this Location"),
          content: new Text(""),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              //color: Color(0xFF556F7A),
              child: new Text("yes"),
              onPressed: () {
                senddata(_currentPosition)
                    .then((value) => Fluttertoast.showToast(
                          msg: "Notifying Hospital please wait",
                        ))
                    .whenComplete(() => {
                          Navigator.of(context).pop(),
                          setState(() {
                            emergency = true;
                          })
                        });
              },
            ),
            new FlatButton(
              //color: Color(0xFF556F7A),
              child: new Text("cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future senddata(Position loc) async {
    await firestoreInstance.collection("users").doc(firebaseUser.uid).set({
      "emergency": true,
      "longitude": loc.longitude,
      "latitude": loc.latitude
    }, SetOptions(merge: true));
  }
}
