import 'package:flutter/material.dart';
import 'package:opendoc/convoScreen.dart';
import 'package:opendoc/widgets.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          tileColor: Colors.green[100],
          leading: CircleAvatar(
            backgroundColor: kAccentColorDark,
            child: Text('D'),
          ),
          title: Text('Dr Priyanshu Shukla'),
          subtitle: Text('Last message'),
          trailing: Text('05:00 PM'),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ConvoScreen()));
          },
        ),
        ListTile(
          tileColor: Colors.green[100],
          leading: CircleAvatar(
            backgroundColor: kAccentColorDark,
            child: Text('D'),
          ),
          title: Text('Dr Priyanshu Shukla'),
          subtitle: Text('Last message'),
          trailing: Text('05:00 PM'),
          onTap: () {},
        )
      ],
    );
  }
}
