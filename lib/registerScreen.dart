import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:opendoc/widgets.dart';

import 'mainScreen.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  var _fireStore = FirebaseFirestore.instance;
  String name, _email, _password, deviceToken;
  bool shuwSpinner = false;

  Future<void> addUserToDatabase(
    String email,
    name,
    deviceToken,
  ) async {
    await _fireStore.collection('users').add({
      'name': name,
      'email': email,
      'verified': false,
      'deviceToken': deviceToken,
      'timestamp': DateTime.now()
    });
  }

  void getToken() async {
    deviceToken = await _firebaseMessaging.getToken();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getToken();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: shuwSpinner,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('asset/logo.png'),
                          fit: BoxFit.fill),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          offset: Offset(2.0, 2.0),
                          blurRadius: 5,
                        )
                      ]),
                ),
              ),
              SizedBox(
                height: 120,
              ),
              TextField(
                decoration:
                    inputDecoration.copyWith(hintText: 'Enter your name'),
                onChanged: (value) {
                  name = value;
                },
              ),
              SizedBox(
                height: 14,
              ),
              TextField(
                decoration: inputDecoration,
                onChanged: (value) {
                  _email = value;
                },
              ),
              SizedBox(
                height: 14,
              ),
              TextField(
                decoration:
                    inputDecoration.copyWith(hintText: 'Enter your password'),
                obscureText: true,
                onChanged: (value) {
                  _password = value;
                },
              ),
              SizedBox(
                height: 14,
              ),
              GestureDetector(
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                      color: kAccentColorDark,
                      borderRadius: BorderRadius.circular(32),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          offset: Offset(2.0, 2.0),
                          blurRadius: 5,
                        )
                      ]),
                  child: Center(
                      child: Text(
                    'Register',
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  )),
                ),
                onTap: () async {
                  if (name != null && _password != null && _email != null) {
                    setState(() {
                      shuwSpinner = true;
                    });
                    try {
                      final newUser =
                          await _firebaseAuth.createUserWithEmailAndPassword(
                              email: _email, password: _password);
                      if (newUser != null) {
                        await addUserToDatabase(_email, name, deviceToken);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MainScreen()));
                      }
                    } catch (e) {
                      print(e);
                    }
                    setState(() {
                      shuwSpinner = false;
                    });
                  } else {
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text('Please enter all fields'),
                    ));
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
