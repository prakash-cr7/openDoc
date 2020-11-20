import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'chatScreen.dart';
import 'dataProvider.dart';

class ChatListScreen extends StatefulWidget {
  @override
  _ChatListScreenState createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  bool verified;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    verified =
        Provider.of<DataProvider>(context, listen: false).getVerification();
  }

  @override
  Widget build(BuildContext context) {
    return verified ? ForDoc() : ForPatient();
  }
}
