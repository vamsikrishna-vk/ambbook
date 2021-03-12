import 'package:ambbook/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'authentication_service.dart';
import 'package:ambbook/Details.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Signup extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SignupState();
  }
}

class _SignupState extends State<Signup> {
  Future val;
  String x = "";
  bool _toggleVisibility = true;
  bool _toggleVisibility1 = true;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController emailController1 = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordController1 = TextEditingController();
  final TextEditingController Name = TextEditingController();
  final TextEditingController Phone = TextEditingController();
  final TextEditingController Age = TextEditingController();
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Container(
            color: Colors.transparent,
            padding: EdgeInsets.all(12),
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
                          "SIGNUP",
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
                                controller: emailController1,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: const BorderRadius.all(
                                      const Radius.circular(10.0),
                                    ),
                                  ),
                                  hintText: 'Reenter Email',
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
                              obscureText: _toggleVisibility1,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _toggleVisibility1 = !_toggleVisibility1;
                                    });
                                  },
                                  icon: _toggleVisibility1
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
                          height: 18,
                        ),
                        SizedBox(
                          height: 50.0,
                          child: TextFormField(
                              controller: passwordController1,
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
                                hintText: 'Confirm Password',
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
                            if (passwordController.text.trim() !=
                                passwordController1.text.trim())
                              {
                                Fluttertoast.showToast(
                                  msg: "passwords Does not match",
                                )
                              }
                            else if (emailController.text.trim() !=
                                emailController1.text.trim())
                              {
                                Fluttertoast.showToast(
                                  msg: "Emails Does not match",
                                )
                              }
                            else
                              {
                                val = context
                                    .read<AuthenticationService>()
                                    .signUp(
                                      email: emailController.text.trim(),
                                      password: passwordController.text.trim(),
                                    )
                                    .whenComplete(() => {
                                          print(val),
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Details()),
                                          ),
                                        })
                              }
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
                              child: Text("Signup",
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
}
