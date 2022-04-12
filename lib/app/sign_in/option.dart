import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:testtt/Common_widget/Sign_in_button.dart';
import 'package:testtt/app/adminlogin/signup.dart';
import 'package:testtt/app/annoucement/announcement_admin.dart';
import 'package:testtt/app/sign_in/control.dart';
import 'package:testtt/app/sign_in/history.dart';

import '../adminlogin/login.dart';

class Option extends StatefulWidget {
  const Option({Key? key}) : super(key: key);

  @override
  State<Option> createState() => OptionState();
}

class OptionState extends State<Option> {
  @override
  late StreamSubscription _appdata;
  final _database = FirebaseDatabase.instance.reference();
  String _displayText = 'Result';
  void initState() {
    super.initState();
    _activeListeners();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: buildContent(),
      backgroundColor: Colors.grey[200],
    );
  }
  Future<void> _activeListeners() async {
    _appdata =
        _database
            .child('Email')
            .onValue
            .listen((event) {
          final String Emaildata = event.snapshot.value.toString();
          setState(() {
            _displayText = Emaildata;
          });
        });
  }

  Widget buildContent() {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('bg3.gif'), fit: BoxFit.cover),
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.white,
              Colors.lightBlue.shade200,
            ],
          )),
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Option',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 48.0),
          SignInButton(
              text: 'Control',
              color: Colors.lime[300],
              tcolor: Colors.black87,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Control()),
                );
              },
              style: 25.0),
          SizedBox(height:8.0),
          SignInButton(
              text: 'Announcement',
              color: Colors.lime[300],
              tcolor: Colors.black87,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AnnouncementAdmin(),
                    )
                );
              },
              style: 25.0),
          SizedBox(height:8.0),
          SignInButton(
              text: 'Check history',
              color: Colors.lime[300],
              tcolor: Colors.black87,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => History(),
                    )
                );
              },
              style: 25.0),// foreground
          SizedBox(height: 15.0),
          Row(
            children: <Widget>[
              SizedBox(width: 55),
              Text('Signed in as: ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                SizedBox(width: 2),
                Text(
                  _displayText,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.deepOrange.shade400,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w600,
                  ),

                )
              ]
          )
        ],
      ),
    );
  }
}
