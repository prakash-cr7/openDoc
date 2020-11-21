import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:opendoc/chatListScreen.dart';
import 'package:opendoc/joinUsScreen.dart';
import 'package:opendoc/updatsScreen.dart';
import 'package:opendoc/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'mainScreenBody.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;

  SharedPreferences _sharedPreferences;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void initSP() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initSP();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screens = [
      MainScreenBody(size: size),
      UpdateScreen(),
      JoinUsScreen(),
      ChatListScreen()
    ];
    var body = screens[selectedIndex];
    return Scaffold(
      appBar: AppBar(
        title: Text('openDoc'),
        centerTitle: true,
        backgroundColor: kAccentColorDark,
        elevation: 0,
      ),
      resizeToAvoidBottomPadding: true,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), label: 'Updates'),
          BottomNavigationBarItem(
              icon: Icon(Icons.medical_services_sharp), label: 'Join us'),
          BottomNavigationBarItem(icon: Icon(Icons.messenger), label: 'Chat'),
        ],
        backgroundColor: Colors.white,
        selectedItemColor: kAccentColorDark,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
      drawer: Drawer(
        child: Stack(children: [
          Container(
            height: MediaQuery.of(context).size.height,
            color: kAccentColorDark,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                color: Colors.green[100],
                height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _firebaseAuth.currentUser.email,
                      style: TextStyle(
                        fontSize: 28,
                        color: kAccentColorDark,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Card(
                color: kAccentColorDark,
                child: GestureDetector(
                  child: ListTile(
                    title: Text(
                      'Sign out',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    leading: Icon(
                      Icons.logout,
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {
                    _sharedPreferences.remove('userInfo');
                    _firebaseAuth.signOut();
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                ),
              ),
              Card(
                color: kAccentColorDark,
                child: GestureDetector(
                  child: ListTile(
                    title: Text(
                      'My account',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    leading: Icon(
                      Icons.account_circle,
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {},
                ),
              ),
              Card(
                color: kAccentColorDark,
                child: GestureDetector(
                  child: ListTile(
                    title: Text(
                      'Support us',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    leading: Icon(
                      Icons.support,
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {},
                ),
              ),
              Card(
                color: kAccentColorDark,
                child: GestureDetector(
                  child: ListTile(
                    title: Text(
                      'Review and Rating',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    leading: Icon(
                      Icons.rate_review,
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {},
                ),
              ),
              Card(
                color: kAccentColorDark,
                child: GestureDetector(
                  child: ListTile(
                    title: Text(
                      'About',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    leading: Icon(
                      Icons.info_outline_rounded,
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {},
                ),
              ),
            ],
          )
        ]),
      ),
      body: body,
    );
  }
}
