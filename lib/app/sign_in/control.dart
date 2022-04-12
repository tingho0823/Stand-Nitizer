import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:testtt/Common_widget/Sign_in_button.dart';
import 'package:testtt/app/sign_in/alert.dart';
import 'dart:math';
import 'package:testtt/app/shownotification/showNotification.dart';

import '../annoucement/getDateTime.dart';
class Control extends StatefulWidget {
  const Control({Key? key}) : super(key: key);

  @override
  State<Control> createState() => ControlState();
}

class ControlState extends State<Control> {
  int _counter = 0;
  String _displayText = 'Result';
  String _displayText2 ='Result1';
  String doorStatus = 'closed';
  Object _notification=0;
  Object notification=0;
  late StreamSubscription _appdata;
  var temperature;
  final _database = FirebaseDatabase.instance.reference();
  Color statusColor = Colors.red;
  Random random = new Random();

  @override
  void initState() {
    super.initState();
    _activeListeners();
    _activeListeners2();
  }

  Future<void> _activeListeners() async {
    _appdata =
        _database
            .child('Sensors/sanitizer_liquid_value')
            .onValue
            .listen((event) {
          final String SanitizerLeveldata = event.snapshot.value.toString();
          setState(() {
            _displayText = SanitizerLeveldata;
          });
        });
  }
  Future<void> _activeListeners2() async {
    _appdata =
        _database
            .child('Email')
            .onValue
            .listen((event) {
          final String Emaildata = event.snapshot.value.toString();
          setState(() {
            _displayText2 = Emaildata;
          });
        });
  }


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Control'), elevation: 2.0),
      body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
              image: AssetImage('bg2.gif'), fit: BoxFit.cover),
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.white,
                  Colors.blue.shade50,
                ],
              )
          ),
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: [
                SizedBox(height: 8.0),
                SizedBox(
                  width: 16,
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(height: 8.0),
                Text(
                  'Sanitizer level(%): ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 2),
                Text(
                  _displayText,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.w600,
                  ),

                )
              ],
            ),
            Row(
              children: [
                SizedBox(height: 8.0),
                Text(
                  'STATUS: ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Container(
                  height: 30.0,
                  width: 30.0,
                  color: statusColor,
                ),
              ],
            ),
            SizedBox(height: 40.0),
            SignInButton(
                text: 'Start!',
                color: Colors.white,
                tcolor: Colors.black87,
                onPressed: () async{
                  try{
                    await _database.update({'Status':'Start',});
                  }catch(e){
                    print('You got an error!');
                  }
                   final String date = getDate();
                    final String time = getTime();

                  setState(() {
                    _counter++;
                    statusColor = Colors.green;
                  });
                await _database.child("record").push().set({
                 'User': _displayText2,
                'Total': _counter,
                'date' :date,
                'time' :time,});

                  showNotification();

                  showAlertDialog2(
                    button: 'ok',
                    message: 'Sanitising',
                    context: context,
                    title: 'Alert',
                  );

                },
                style: 30.0),
            SizedBox(height: 15.0),

            SignInButton(
                text: 'S.T.O.P !',
                color: Colors.red,
                tcolor: Colors.white,
                onPressed: () async {
                  try {
                    await _database.update({'Status': 'Stop',});
                  } catch (e) {
                    print('You got an error!');
                  }

                  showAlertDialog2(
                    button: 'ok',
                    message: 'Sanitisor stopped!',
                    context: context,
                    title: 'Alert',
                  );
                  showNotification2();
                  setState(() {
                    statusColor = Colors.red;
                  });
                },
                style: 30.0),
            SizedBox(height: 8.0),
            SignInButton(
                text: 'RESET',
                color: Colors.white,
                tcolor: Colors.black87,
                onPressed: () async {
                  showNotification3();
                  try {
                    await _database.update({'Status': 'Stop',});
                  } catch (e) {
                    print('You got an error!');
                  }
                },
                style: 30.0),
          ],
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }

  void deactivate() {
    _appdata.cancel();
    super.deactivate();
  }

  void showNotification() {
    flutterLocalNotificationsPlugin.show(
        0,
        "You are being sanitizered now",
        "Please wait...",
        NotificationDetails(
            android: AndroidNotificationDetails(channel.id, channel.name,
                importance: Importance.high,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher')));
  }
  void showNotification2() {
    flutterLocalNotificationsPlugin.show(
        0,
        "The sanitizer has stopped",
        "You may leave now",
        NotificationDetails(
            android: AndroidNotificationDetails(channel.id, channel.name,
                importance: Importance.high,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher')));
  }
  void showNotification3() {
    flutterLocalNotificationsPlugin.show(
        0,
        "The sanitizer is resetting now",
        "Please wait...",
        NotificationDetails(
            android: AndroidNotificationDetails(channel.id, channel.name,
                importance: Importance.high,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher')));
  }

}

