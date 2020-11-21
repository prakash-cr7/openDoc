import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:opendoc/convoScreen.dart';
import 'package:opendoc/widgets.dart';
import 'package:provider/provider.dart';

import 'dataProvider.dart';

class ForDoc extends StatefulWidget {
  @override
  _ForDocState createState() => _ForDocState();
}

class _ForDocState extends State<ForDoc> {
  var _fireStore = FirebaseFirestore.instance;
  String email;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    email = Provider.of<DataProvider>(context, listen: false).getEmail();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _fireStore
          .collection('chat')
          .where('doctorEmail', isEqualTo: email)
          .orderBy('timeStamp', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        final chats = snapshot.data.documents;
        List<Widget> items = [];
        for (var chat in chats) {
          String name = chat.data()['patientName'];
          String email = chat.data()['patientEmail'];
          final Widget item = ChatTile(
            name: name,
            email: email,
            chat: chat,
          );
          items.add(item);
        }
        return items.length == 0
            ? Center(
                child: Text(
                  'Your chats will appear here',
                  style: TextStyle(color: kAccentColorDark, fontSize: 16),
                ),
              )
            : ListView(
                children: items,
              );
      },
    );
  }
}

class ForPatient extends StatefulWidget {
  @override
  _ForPatientState createState() => _ForPatientState();
}

class _ForPatientState extends State<ForPatient> {
  var _fireStore = FirebaseFirestore.instance;
  String email;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    email = Provider.of<DataProvider>(context, listen: false).getEmail();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _fireStore
          .collection('chat')
          .where('patientEmail', isEqualTo: email)
          .orderBy('timeStamp', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        final chats = snapshot.data.documents;
        List<Widget> items = [];
        for (var chat in chats) {
          String name = chat.data()['doctorName'];
          String email = chat.data()['doctorEmail'];
          final Widget item = ChatTile(
            name: name,
            email: email,
          );
          items.add(item);
        }
        return items.length == 0
            ? Center(
                child: Text(
                  'Your chats will appear here',
                  style: TextStyle(color: kAccentColorDark, fontSize: 16),
                ),
              )
            : ListView(
                children: items,
              );
      },
    );
  }
}

class ChatTile extends StatelessWidget {
  ChatTile({this.name, this.chat, this.email = ''});

  final String name, email;
  final chat;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
            subtitle: Text(email),
            tileColor: Colors.green[100],
            leading: CircleAvatar(
              backgroundColor: kAccentColorDark,
              child: Text(
                name[0],
                style: TextStyle(color: Colors.white),
              ),
            ),
            title: Text(name),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ConvoScreen(
                            chat: chat,
                          )));
            }),
        Divider(
          height: 1,
          color: kAccentColorDark,
        )
      ],
    );
  }
}
