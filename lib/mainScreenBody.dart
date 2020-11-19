import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:opendoc/widgets.dart';

class MainScreenBody extends StatefulWidget {
  const MainScreenBody({
    @required this.size,
  });

  final Size size;

  @override
  _MainScreenBodyState createState() => _MainScreenBodyState();
}

class _MainScreenBodyState extends State<MainScreenBody> {
  String sicknessTypeHint = 'Sickness Type';
  String genderHint = 'Select Gender';

  Future<Widget> alert(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Enter all details'),
            content: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                        border: Border.all(color: kAccentColorDark),
                      ),
                      height: 60,
                      child: DropdownButton<String>(
                          hint: Text(
                            'Sickness type',
                          ),
                          items: [
                            DropdownMenuItem<String>(
                                child: Text('Allergies'), value: 'Allergies'),
                            DropdownMenuItem<String>(
                                child: Text('Colds and Flu'),
                                value: 'Colds and Flu'),
                            DropdownMenuItem<String>(
                                child: Text('Diarrhea'), value: 'Diarrhea'),
                            DropdownMenuItem<String>(
                                child: Text('Headaches'), value: 'Headaches'),
                            DropdownMenuItem<String>(
                                child: Text('Other'), value: 'Other'),
                          ],
                          onChanged: (value) {
                            setState(() {
                              sicknessTypeHint = value;
                            });
                          })),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                        border: Border.all(color: kAccentColorDark),
                      ),
                      height: 60,
                      child: DropdownButton<String>(
                          hint: Text(
                            genderHint,
                          ),
                          items: [
                            DropdownMenuItem<String>(
                                child: Text('Male'), value: 'Male'),
                            DropdownMenuItem<String>(
                                child: Text('Female'), value: 'Female')
                          ],
                          onChanged: (value) {
                            setState(() {
                              genderHint = value;
                            });
                          })),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    decoration: inputDecoration.copyWith(hintText: 'Enter age'),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {},
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    // style: TextStyle(height: 6, fontSize: 18),
                    decoration:
                        inputDecoration.copyWith(hintText: 'Short description'),
                    keyboardType: TextInputType.text,
                    onChanged: (value) {},
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    decoration:
                        inputDecoration.copyWith(hintText: 'Phone number'),
                    keyboardType: TextInputType.phone,
                    onChanged: (value) {},
                  )
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: kAccentColorDark),
                  )),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Request',
                    style: TextStyle(color: kAccentColorDark),
                  )),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: widget.size.height * 0.2,
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
          height: widget.size.height * 0.53,
          child: GridView.count(
            primary: false,
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1,
            children: [
              ContentBox(
                top: 10,
                left: 16,
              ),
              ContentBox(
                left: 10,
                right: 16,
                top: 10,
              ),
              ContentBox(
                bottom: 10,
                left: 16,
              ),
              ContentBox(
                bottom: 10,
                left: 10,
                right: 16,
              ),
            ],
          ),
        ),
        GestureDetector(
          child: SignInBox(
            text: 'Request Appointment',
          ),
          onTap: () {
            alert(context);
          },
        ),
      ],
    );
  }
}
