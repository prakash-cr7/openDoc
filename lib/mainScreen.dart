import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:opendoc/chatScreen.dart';
import 'package:opendoc/joinUsScreen.dart';
import 'package:opendoc/updatsScreen.dart';
import 'package:opendoc/widgets.dart';

import 'mainScreenBody.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screens = [
      MainScreenBody(size: size),
      UpdateScreen(),
      JoinUsScreen(),
      ChatScreen()
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
      drawer: Drawer(),
      body: body,
    );
  }
}
