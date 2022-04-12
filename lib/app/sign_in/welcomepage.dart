import 'package:flutter/material.dart';
import 'package:testtt/Common_widget/sign_in_button.dart';
import 'package:testtt/app/sign_in/introduction_page.dart';

class Welcomepage extends StatefulWidget {
  const Welcomepage({Key? key}) : super(key: key);

  @override
  State<Welcomepage> createState() => _WelcomepageState();
}

class _WelcomepageState extends State<Welcomepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildContent(),
    );
  }
  Widget buildContent() {
    return Container(
      decoration: BoxDecoration(
        image:
            DecorationImage(image: AssetImage("image1.gif"), fit: BoxFit.cover),
      ),
      padding: EdgeInsets.all(16.0),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Image.asset('image2.png',height: 230,),
          SignInButton(
              text: "Start! ➜",
              color: Colors.purple.shade900,
              tcolor: Colors.white,
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>OnBoardingPage()),
                );
              },
              style: 28.0),
          SizedBox(height: 8.0),
        ],
      ),
    );
  }
}
