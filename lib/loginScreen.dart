import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:opendoc/widgets.dart';

import 'mainScreen.dart';

class LogIn extends StatefulWidget {
  static FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static String _email, _password;

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
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
                decoration: inputDecoration,
                onChanged: (value) {
                  LogIn._email = value;
                },
              ),
              SizedBox(
                height: 14,
              ),
              TextField(
                decoration:
                    inputDecoration.copyWith(hintText: 'Enter your password'),
                onChanged: (value) {
                  LogIn._password = value;
                },
                obscureText: true,
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
                    'Log in',
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  )),
                ),
                onTap: () async {
                  if (LogIn._email != null && LogIn._password != null) {
                    setState(() {
                      showSpinner = true;
                    });
                    try {
                      final loginUser = await LogIn._firebaseAuth
                          .signInWithEmailAndPassword(
                              email: LogIn._email, password: LogIn._password);
                      if (loginUser != null) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MainScreen()));
                      }
                      setState(() {
                        showSpinner = false;
                      });
                    } catch (e) {
                      print(e);
                    }
                  } else {
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text('There is an error'),
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
