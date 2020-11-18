import 'package:flutter/material.dart';
import 'package:opendoc/widgets.dart';

class LogIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        image: AssetImage('asset/logo.png'), fit: BoxFit.fill),
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
            ),
            SizedBox(
              height: 14,
            ),
            TextField(
              decoration:
                  inputDecoration.copyWith(hintText: 'Enter your password'),
              obscureText: true,
            ),
            SizedBox(
              height: 14,
            ),
            Container(
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
            )
          ],
        ),
      ),
    );
  }
}
