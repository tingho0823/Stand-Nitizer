import 'package:flutter/material.dart';
import 'package:testtt/app/sign_in/welcomepage.dart';
import 'package:firebase_core/firebase_core.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: Welcomepage(),
    );
  }
}
