import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
          final Widget item = ChatTile(
            name: name,
            onTap: () {},
          );
          items.add(item);
        }
        return ListView(
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
          final Widget item = ChatTile(
            name: name,
            onTap: () {},
          );
          items.add(item);
        }
        return ListView(
          children: items,
        );
      },
    );
  }
}

class ChatTile extends StatelessWidget {
  ChatTile({this.name, this.onTap});

  final String name;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        tileColor: Colors.green[100],
        leading: CircleAvatar(
          backgroundColor: kAccentColorDark,
          child: Text(
            name[0],
            style: TextStyle(color: Colors.white),
          ),
        ),
        title: Text(name),
        onTap: onTap);
  }
}
