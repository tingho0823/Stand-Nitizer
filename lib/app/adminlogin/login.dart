import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:testtt/app/adminlogin/authetication.dart';
import '../sign_in/option.dart';
import '../sign_in/sign_in_page.dart';
import 'forget_password.dart';
import 'package:local_auth/local_auth.dart';
import 'package:testtt/app/fingerprint_auth/local_auth_api.dart';
import 'package:testtt/app/fingerprint_auth/home_page.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(decoration: BoxDecoration(
        image: DecorationImage(
        image: AssetImage("image1.gif"), fit: BoxFit.cover),
      ),
      child: ListView(
        padding: EdgeInsets.all(8.0),
        children: <Widget>[
          SizedBox(height: 130),
          // logo
          Column(
            children: [
              Image.asset('intro5.png',height: 130),
              SizedBox(height: 50),
              Text(
                'Welcome back!',
                style: TextStyle(fontSize: 24),
              ),
            ],
          ),
          SizedBox(
            height: 0,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: LoginForm(),
          ),

          SizedBox(height: 20),

        ],
      ),
    )
    );
  }
}

class LoginForm extends StatefulWidget {
  LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  String? email;
  String? password;
  final _database = FirebaseDatabase.instance.reference();

  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          // email
          TextFormField(
            // initialValue: 'Input text',
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.email_outlined),
              labelText: 'Email',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  const Radius.circular(100.0),
                ),
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter Email';
              }
              return null;
            },
            onSaved: (val) {
              email = val;
            },
          ),
          SizedBox(
            height: 20,
          ),

          // password
          TextFormField(
            // initialValue: 'Input text',
            decoration: InputDecoration(
              labelText: 'Password',
              prefixIcon: Icon(Icons.lock_outline),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  const Radius.circular(100.0),
                ),
              ),
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                child: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                ),
              ),
            ),
            obscureText: _obscureText,
            onSaved: (val) {
              password = val;
            },
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter Password';
              }
              return null;
            },
          ),

          SizedBox(height: 10),
          buildAuthenticate(context),
          SizedBox(height:10),
          SizedBox(
            height: 54,
            width: 184,
            child: ElevatedButton(

              onPressed: () async{
                // Respond to button press

                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();

                  AuthenticationHelper()
                      .signIn(email: email!, password: password!)
                      .then((result) async {
                    if (result == null) {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Option()));
                      try{
                        await _database.update({'Email':email!,});
                      }catch(e){
                        print('You got an error!');
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          result,
                          style: TextStyle(fontSize: 16),
                        ),
                      ));
                    }
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(

                    borderRadius: BorderRadius.circular(50.0),

                  )
              ),
              child: Text(
                'Login',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
          Row(
            children: <Widget>[
              SizedBox(width: 80),
              GestureDetector(
                onTap: () {
                  // Navigator.pushNamed(context, '/signup');
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ForgetPassword()));
                },
                child: Text('Forget Password?',
                    style: TextStyle(fontSize: 18, color: Colors.blue)),
              )
            ],
          ),
        ],
      ),
    );
  }
}

Widget buildAuthenticate(BuildContext context) => buildButton(
  text: 'Fingerprint',
  icon: Icons.fingerprint,
  onClicked: () async {
    final isAuthenticated = await LocalAuthApi.authenticate();

    if (isAuthenticated) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => Option()),
      );
    }
  },
);
Widget buildButton({
  required String text,
  required IconData icon,
  required VoidCallback onClicked,
}) =>
    ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        minimumSize: Size.fromHeight(50),
        shape: RoundedRectangleBorder(

          borderRadius: BorderRadius.circular(50.0),

        ),
      ),
      icon: Icon(icon, size: 26),
      label: Text(
        text,
        style: TextStyle(fontSize: 20),
      ),


      onPressed: onClicked,
    );