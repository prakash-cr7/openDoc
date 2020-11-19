import 'package:flutter/material.dart';
import 'package:opendoc/widgets.dart';

class JoinUsScreen extends StatelessWidget {
  Future<Widget> alert(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title:
                Text('Admin will contact you through e-mail for verification'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'cancel',
                    style: TextStyle(color: kAccentColorDark),
                  )),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'send',
                    style: TextStyle(color: kAccentColorDark),
                  )),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
            child: Text(
          'Join us as a Doctor and help the community...',
          style: TextStyle(
            fontSize: 18,
          ),
        )),
        SizedBox(
          height: 10,
        ),
        GestureDetector(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 65),
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                  color: kAccentColorDark,
                  borderRadius: BorderRadius.circular(32),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      offset: Offset(2.0, 2.0),
                      blurRadius: 5,
                    )
                  ]),
              child: Center(
                  child: Text(
                'Request verification',
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
              )),
            ),
          ),
          onTap: () {
            alert(context);
          },
        )
      ],
    );
  }
}
