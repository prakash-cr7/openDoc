import 'package:flutter/material.dart';

class UpdateScreen extends StatelessWidget {
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
            subtitle: Text('status: pending'),
            trailing: Text('10:30 PM'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
          child: ListTile(
            tileColor: Colors.green[100],
            leading: Text('Fever'),
            title: Text('Appointment request by Prakash '),
            subtitle: Text('status: pending'),
            trailing: Text('10:30 PM'),
          ),
        ),
      ],
    );
  }
}
