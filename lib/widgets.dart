import 'package:flutter/material.dart';

const Color kAccentColorDark = Color(0xff005f40);
const int kHorizontalPadding = 24;
const int kBorderRadius = 32;

const inputDecoration = InputDecoration(
  hintText: 'Enter your email',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kAccentColorDark, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kAccentColorDark, width: 4.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

class SignInBox extends StatelessWidget {
  SignInBox({this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 24),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
            color: Colors.green,
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
          text,
          style: TextStyle(
              fontSize: 30, color: Colors.white, fontWeight: FontWeight.w500),
        )),
      ),
    );
  }
}
