import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'widgets.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'openDoc',
      theme: ThemeData(
          backgroundColor: Color(0xff005040),
          textTheme: GoogleFonts.ubuntuTextTheme(
            Theme.of(context).textTheme,
          )),
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff005f40),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Center(
            child: Container(
              height: 320,
              width: 320,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('asset/logo.png'), fit: BoxFit.fill)),
            ),
          ),
          SizedBox(
            height: 150,
          ),
          SignInBox(
            text: 'Register',
          ),
          SignInBox(
            text: 'Sign in',
          ),
          SizedBox(
            height: 18,
          )
        ],
      ),
    );
  }
}
