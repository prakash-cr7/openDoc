import 'package:flutter/material.dart';

import 'widgets.dart';

class VerifiedDocScreen extends StatelessWidget {
  Future<Widget> alert(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title:
                Text('Accept or decline appointment request.'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Decline',
                    style: TextStyle(color: kAccentColorDark),
                  )),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Accept',
                    style: TextStyle(color: kAccentColorDark),
                  )),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
          child: ListTile(
            tileColor: Colors.green[100],
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Cold'),
                SizedBox(
                  height: 4,
                ),
                Text('Male 29')
              ],
            ),
            title: Text('Appointment request by Prakash '),
            subtitle: Text('10: 30 PM'),
            trailing: TextButton(
              child: Text('Accept'),
              onPressed: () {
                alert(context);
              },
            ),
          ),
        ),
      ],
    );
  }
}
