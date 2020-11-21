import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color kAccentColorDark = Color(0xff005f40);
const int kHorizontalPadding = 24;
const int kBorderRadius = 32;

const kSendButtonTextStyle = TextStyle(
  color: kAccentColorDark,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: kAccentColorDark, width: 2.0),
  ),
);

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
  SignInBox({this.text, this.backgroundColor = kAccentColorDark});
  final String text;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 24),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
            color: backgroundColor,
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

class ContentBox extends StatelessWidget {
  ContentBox(
      {this.left = 0,
      this.bottom = 0,
      this.right = 0,
      this.top = 0,
      this.text,
      this.imageLink});
  final double right, left, top, bottom;
  final String imageLink, text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(top: top, bottom: bottom, left: left, right: right),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
            color: Colors.green[100],
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                offset: Offset(1.0, 1.0),
                blurRadius: 3,
              )
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(imageLink), fit: BoxFit.fitHeight),
                ),
              ),
            ),
            Text(
              text,
              style: GoogleFonts.acme(fontSize: 24, color: kAccentColorDark),
            ),
            SizedBox(
              height: 6,
            )
          ],
        ),
      ),
    );
  }
}
