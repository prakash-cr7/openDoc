import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:opendoc/verifiedDocScreen.dart';
import 'package:opendoc/widgets.dart';
import 'package:provider/provider.dart';

import 'dataProvider.dart';

class JoinUsScreen extends StatefulWidget {
  @override
  _JoinUsScreenState createState() => _JoinUsScreenState();
}

class _JoinUsScreenState extends State<JoinUsScreen> {
  var _fireStore = FirebaseFirestore.instance;
  bool verified;
  String email;

  Future<Widget> alert(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title:
                Text('Admin will contact you through e-mail for verification'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'cancel',
                    style: TextStyle(color: kAccentColorDark),
                  )),
              TextButton(
                  onPressed: () async {
                    await _fireStore
                        .collection('verification')
                        .add({'email': email});
                    Navigator.pop(context);
                  },
                  child: Text(
                    'send',
                    style: TextStyle(color: kAccentColorDark),
                  )),
            ],
          );
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    verified =
        Provider.of<DataProvider>(context, listen: false).getVerification();
    email = Provider.of<DataProvider>(context, listen: false).getEmail();
  }

  @override
  Widget build(BuildContext context) {
    return verified
        ? DocScreen()
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                  child: Text(
                'Join us as a Doctor and help the community...',
                style: TextStyle(
                  fontSize: 18,
                ),
              )),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 65),
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
                      'Request verification',
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    )),
                  ),
                ),
                onTap: () {
                  alert(context);
                },
              )
            ],
          );
  }
}
