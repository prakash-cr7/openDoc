import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'dataProvider.dart';

class UpdateScreen extends StatefulWidget {
  @override
  _UpdateScreenState createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  var timeFormat = DateFormat.d('en_us').add_Hm();
  String email;
  var _fireStore = FirebaseFirestore.instance;

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
          .collection('appointments')
          .where('email', isEqualTo: email)
          .where('status', isEqualTo: 'pending')
          .orderBy('timeStamp', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        final appointments = snapshot.data.documents;
        List<Widget> items = [];
        for (var appointment in appointments) {
          String age = appointment.data()['age'];
          String gender = appointment.data()['gender'];
          String type = appointment.data()['sicknessType'];
          final Widget item = UpdatesTile(
            gender: gender,
            sicknessType: type,
            age: age,
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

class UpdatesTile extends StatelessWidget {
  UpdatesTile({this.gender, this.age, this.sicknessType, this.time = ''});
  final String sicknessType, gender, age, time;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: ListTile(
        tileColor: Colors.green[100],
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(sicknessType),
            SizedBox(
              height: 4,
            ),
            Text('$gender $age')
          ],
        ),
        title: Text('Appointment request by you'),
        subtitle: Text('status: pending'),
        trailing: Text(time),
      ),
    );
  }
}
