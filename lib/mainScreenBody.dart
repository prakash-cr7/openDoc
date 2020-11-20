import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:opendoc/widgets.dart';
import 'package:provider/provider.dart';

import 'dataProvider.dart';

class MainScreenBody extends StatefulWidget {
  const MainScreenBody({
    @required this.size,
  });

  final Size size;

  @override
  _MainScreenBodyState createState() => _MainScreenBodyState();
}

class _MainScreenBodyState extends State<MainScreenBody> {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  var _fireStore = FirebaseFirestore.instance;
  String sicknessTypeHint = 'Sickness Type';
  String genderHint = 'Select Gender';
  bool verified;
  String sicknessType, gender, age, description, phone, name = '', email;

  Future<void> getUser() async {
    var currentUser = _firebaseAuth.currentUser;
    if (currentUser != null) {
      email = currentUser.email;
      var userSnapshot = await _fireStore
          .collection('users')
          .where('email', isEqualTo: email)
          .get();
      var data = userSnapshot.docs[0].data();
      // userDocId = userSnapshot.docs[0].id;
      Provider.of<DataProvider>(context, listen: false).setEmail(email);
      name = data['name'];
      Provider.of<DataProvider>(context, listen: false).setName(name);
      verified = data['verified'];
      Provider.of<DataProvider>(context, listen: false)
          .setVerification(verified);
      setState(() {});
    }
  }

  Future<void> createAppointment(
      String sicknessType, gender, age, description, phone, name, email) async {
    if (!verified) {
      if (sicknessType != null &&
          gender != null &&
          age != null &&
          description != null &&
          phone != null) {
        await _fireStore.collection('appointments').add({
          'timeStamp': DateTime.now(),
          'status': 'pending',
          'sicknessType': sicknessType,
          'gender': gender,
          'age': age,
          'description': description,
          'phone': phone,
          'name': name,
          'email': email
        });
      } else {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('Enter all fields'),
        ));
      }
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('You are verified as doctor'),
      ));
    }
  }

  Future<Widget> alert(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Enter all details'),
            content: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                        border: Border.all(color: kAccentColorDark),
                      ),
                      height: 60,
                      child: DropdownButton<String>(
                          hint: Text(
                            sicknessTypeHint,
                          ),
                          items: [
                            DropdownMenuItem<String>(
                                child: Text('Allergies'), value: 'Allergies'),
                            DropdownMenuItem<String>(
                                child: Text('Colds'), value: 'Colds'),
                            DropdownMenuItem<String>(
                                child: Text('Diarrhea'), value: 'Diarrhea'),
                            DropdownMenuItem<String>(
                                child: Text('Headaches'), value: 'Headaches'),
                            DropdownMenuItem<String>(
                                child: Text('Other'), value: 'Other'),
                          ],
                          onChanged: (value) {
                            setState(() {
                              sicknessTypeHint = value;
                              sicknessType = value;
                            });
                          })),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                        border: Border.all(color: kAccentColorDark),
                      ),
                      height: 60,
                      child: DropdownButton<String>(
                          hint: Text(
                            genderHint,
                          ),
                          items: [
                            DropdownMenuItem<String>(
                                child: Text('Male'), value: 'Male'),
                            DropdownMenuItem<String>(
                                child: Text('Female'), value: 'Female')
                          ],
                          onChanged: (value) {
                            setState(() {
                              genderHint = value;
                              gender = value;
                            });
                          })),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    decoration: inputDecoration.copyWith(hintText: 'Enter age'),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      age = value.toString();
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    // style: TextStyle(height: 6, fontSize: 18),
                    decoration:
                        inputDecoration.copyWith(hintText: 'Short description'),
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      description = value;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    decoration:
                        inputDecoration.copyWith(hintText: 'Phone number'),
                    keyboardType: TextInputType.phone,
                    onChanged: (value) {
                      phone = value.toString();
                    },
                  )
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: kAccentColorDark),
                  )),
              TextButton(
                  onPressed: () {
                    createAppointment(sicknessType, gender, age, description,
                        phone, name, email);
                    sicknessType = null;
                    description = null;
                    phone = null;
                    gender = null;
                    age = null;
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Request',
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
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return name == ''
        ? Center(child: CircularProgressIndicator())
        : WillPopScope(
            onWillPop: () async => false,
            child: Column(
              children: [
                Container(
                  height: widget.size.height * 0.2,
                  decoration: BoxDecoration(
                      color: kAccentColorDark,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(32),
                          bottomRight: Radius.circular(32))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 18, top: 18),
                            child: Text(
                              'Hello',
                              style: GoogleFonts.acme(
                                  fontSize: 30, color: Colors.white),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 18),
                            child: Text(
                              '$name!',
                              style: GoogleFonts.acme(
                                  fontSize: 34, color: Colors.white),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('asset/logo1.png'),
                                  fit: BoxFit.fill)),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: widget.size.height * 0.53,
                  child: GridView.count(
                    primary: false,
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1,
                    children: [
                      ContentBox(
                        top: 10,
                        left: 16,
                      ),
                      ContentBox(
                        left: 10,
                        right: 16,
                        top: 10,
                      ),
                      ContentBox(
                        bottom: 10,
                        left: 16,
                      ),
                      ContentBox(
                        bottom: 10,
                        left: 10,
                        right: 16,
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  child: SignInBox(
                    text: 'Request Appointment',
                  ),
                  onTap: () {
                    alert(context);
                  },
                ),
              ],
            ),
          );
  }
}
