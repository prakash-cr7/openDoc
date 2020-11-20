import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:opendoc/registerScreen.dart';
import 'package:provider/provider.dart';

import 'dataProvider.dart';
import 'loginScreen.dart';
import 'widgets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DataProvider>(
      create: (context) => DataProvider(),
      child: MaterialApp(
        title: 'openDoc',
        theme: ThemeData(
            accentColor: Color(0xff005f40),
            backgroundColor: Color(0xff005f40),
            textTheme: GoogleFonts.ubuntuTextTheme(
              Theme.of(context).textTheme,
            )),
        home: Home(),
      ),
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
          GestureDetector(
            child: SignInBox(
              text: 'Register',
              backgroundColor: Colors.green,
            ),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Register()));
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                child: Text('Already signed up? login here.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    )),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LogIn()));
                },
              ),
              SizedBox(
                width: 24,
              ),
            ],
          ),
          SizedBox(
            height: 18,
          )
        ],
      ),
    );
  }
}
