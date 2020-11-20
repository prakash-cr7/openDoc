import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dataProvider.dart';
import 'widgets.dart';

class DocScreen extends StatefulWidget {
  @override
  _DocScreenState createState() => _DocScreenState();
}

class _DocScreenState extends State<DocScreen> {
  var _fireStore = FirebaseFirestore.instance;
  String docName, email;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    docName = Provider.of<DataProvider>(context, listen: false).getName();
    email = Provider.of<DataProvider>(context, listen: false).getEmail();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _fireStore
          .collection('appointments')
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
          String name = appointment.data()['name'];
          final Widget item = VerifiedDocScreen(
            gender: gender,
            sicknessType: type,
            age: age,
            name: name,
            onAccept: () async {
              var doc = _fireStore
                  .collection('appointments')
                  .doc(appointment.documentID);
              doc.update({'status': 'accepted'});
              var ss = await doc.get();
              var data = ss.data();
              _fireStore.collection('chat').add({
                'timeStamp': DateTime.now(),
                'doctorEmail': email,
                'doctorName': docName,
                'patientEmail': data['email'],
                'patientName': data['name'],
                'description': data['description']
              });
              Navigator.pop(context);
            },
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

class VerifiedDocScreen extends StatelessWidget {
  VerifiedDocScreen(
      {this.gender, this.age, this.sicknessType, this.name, this.onAccept});
  final String sicknessType, gender, age, name;
  final Function onAccept;

  Future<Widget> alert(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Accept or decline appointment request.'),
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
                  onPressed: onAccept,
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
        title: Text('Appointment request by $name'),
        trailing: TextButton(
          child: Text('Accept'),
          onPressed: () {
            alert(context);
          },
        ),
      ),
    );
  }
}
