import 'package:flutter/material.dart';

import 'Signup.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'authentication_service.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: new Login(),
    );
  }
}

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginState();
  }
}

class _LoginState extends State<Login> {
  bool _toggleVisibility = true;
  @override
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
                  height: 500,
                  alignment: Alignment.center,
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "LOGIN",
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
                            height: 50.0,
                            child: TextFormField(
                                controller: emailController,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: const BorderRadius.all(
                                      const Radius.circular(10.0),
                                    ),
                                  ),
                                  hintText: 'Email',
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
                              controller: passwordController,
                              obscureText: _toggleVisibility,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _toggleVisibility = !_toggleVisibility;
                                    });
                                  },
                                  icon: _toggleVisibility
                                      ? Icon(
                                          Icons.visibility_off,
                                          color: Color(0xFFef7f1a),
                                        )
                                      : Icon(Icons.visibility,
                                          color: Color(0xFFef7f1a)),
                                ),
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: const BorderRadius.all(
                                    const Radius.circular(10.0),
                                  ),
                                ),
                                hintText: 'Password',
                                filled: true,
                                fillColor: new Color.fromRGBO(0, 0, 0, 240.0),
                                contentPadding: const EdgeInsets.only(
                                    left: 14.0, bottom: 8.0, top: 8.0),
                              )),
                        ),
                        SizedBox(
                          height: 33,
                        ),
                        InkWell(
                          onTap: () => {
                            context.read<AuthenticationService>().signIn(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                ),
                          },
                          child: Container(
                            height: 33,
                            width: 99,
                            decoration: BoxDecoration(
                              color: Color(0xFFef7f1a),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Center(
                              child: Text("Login",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500)),
                            ),
                          ),
                        ),
                        SizedBox(height: 33),
                        InkWell(
                          onTap: () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Signup()),
                            )
                          },
                          child: Container(
                            color: Colors.transparent,
                            child: Center(
                              child: Text("New User? Signup",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400)),
                            ),
                          ),
                        ),
                        SizedBox(height: 11),
                        //Text(
                        // "or",
                        // style: TextStyle(
                        //    color: Colors.black,
                        //  ),
                        // ),
                        //SizedBox(height: 11),
                        //*InkWell(
                        //  onTap: () {},
                        // child: Container(
                        // child: Center(
                        //  child: Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        // children: <Widget>[
                        //  Image.asset("images/google.png"),
                        //  SizedBox(width: 5),
                        //   Text("Log in with Google")
                        //  ],
                        //  ),
                        // ),
                        // height: 60,
                        //  width: 250,
                        // padding: EdgeInsets.all(1),
                        //decoration: BoxDecoration(
                        //   color: Colors.white,
                        //  boxShadow: [
                        //     BoxShadow(
                        //     color: Colors.black.withOpacity(0.1),
                        //     blurRadius: 10,
                        //      offset: Offset(0, 2),
                        //    ),
                        //  ],
                        //   borderRadius:
                        //      BorderRadius.all(Radius.circular(5))),
                        //),
                        //),
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
}
