import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:opendoc/chatScreen.dart';
import 'package:opendoc/joinUsScreen.dart';
import 'package:opendoc/updatsScreen.dart';
import 'package:opendoc/widgets.dart';

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

class MainScreenBody extends StatelessWidget {
  const MainScreenBody({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: size.height * 0.2,
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
                      style:
                          GoogleFonts.acme(fontSize: 30, color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 18),
                    child: Text(
                      'Prakash!',
                      style:
                          GoogleFonts.acme(fontSize: 40, color: Colors.white),
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
          height: size.height * 0.52,
        ),
        SignInBox(
          text: 'Request Appointment',
        )
      ],
    );
  }
}
