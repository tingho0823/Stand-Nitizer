import 'package:flutter/material.dart';
import 'package:testtt/Common_widget/Sign_in_button.dart';
import 'package:testtt/app/adminlogin/signup.dart';
import '../adminlogin/login.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => SignInPageState();
}

class SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildContent(),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget buildContent() {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("image1.gif"), fit: BoxFit.cover),
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.white,
              Colors.lightBlueAccent,
            ],
          )),
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Sign In',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 48.0),
          SignInButton(
              text: 'Admin',
              color: Colors.lime[300],
              tcolor: Colors.black87,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
              },
              style: 25.0),

          // foreground
          SizedBox(height: 15.0),
          Row(
            children: <Widget>[
              SizedBox(width: 30),
              Text('Not a admin yet ? ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
              GestureDetector(
                onTap: () {
                  // Navigator.pushNamed(context, '/signup');
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Signup()));
                },
                child: Text('Register Now!',
                    style: TextStyle(fontSize: 17, color: Colors.blue)),
              )
            ],
          )
        ],
      ),
    );
  }
}
