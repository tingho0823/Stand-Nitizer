import 'package:flutter/material.dart';
import 'package:testtt/app/adminlogin/authetication.dart';
import 'package:testtt/app/sign_in/sign_in_page.dart';

class Signup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(decoration: BoxDecoration(
        image: DecorationImage(
        image: AssetImage("image1.gif"), fit: BoxFit.cover),
    ),
      child:ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          SizedBox(height: 80),
          // logo
          Column(
            children: [
              Image.asset('intro5.png',height: 130),
            ],
          ),
          SizedBox(height: 50),
          Text(
            'Welcome!',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SignupForm(),
          ),

          Expanded(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text('Already here  ?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15)),

                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(' Get Logged in Now!',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 15, color: Colors.blue)),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }

  Container buildLogo() {
    return Container(
      height: 80,
      width: 80,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.blue),
      child: Center(
        child: Text(
          "T",
          style: TextStyle(color: Colors.white, fontSize: 60.0),
        ),
      ),
    );
  }
}

class SignupForm extends StatefulWidget {
  SignupForm({Key? key}) : super(key: key);

  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();

  String? email;
  String? password;
  String? name;
  bool _obscureText = false;
  bool _obscureText1 =false;

  bool agree = false;

  final pass = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    var border = OutlineInputBorder(
      borderRadius: BorderRadius.all(
        const Radius.circular(100.0),
      ),
    );

    var space = SizedBox(height: 10);
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          // email
          TextFormField(
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.email_outlined),
                labelText: 'Email',
                border: border),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter Email';
              }
              return null;
            },
            onSaved: (val) {
              email = val;
            },
            keyboardType: TextInputType.emailAddress,
          ),

          space,

          // password
          TextFormField(
            controller: pass,
            decoration: InputDecoration(
              labelText: 'Password',
              prefixIcon: Icon(Icons.lock_outline),
              border: border,
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
            onSaved: (val) {
              password = val;
            },
            obscureText: !_obscureText,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter Password';
              }
              return null;
            },
          ),
          space,
          // confirm passwords
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Confirm Password',
              prefixIcon: Icon(Icons.lock_outline),
              border: border,
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      _obscureText1 = !_obscureText1;
                    });
                  },
                  child: Icon(
                    _obscureText1 ? Icons.visibility_off : Icons.visibility,
                  ),
                )            ),
            obscureText: true,
            validator: (value) {
              if (value != pass.text) {
                return 'password not match';
              }
              else if(value!.isEmpty) {
                return 'Please enter Password';
              }
              return null;
            },
          ),
          space,
          // name
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Full name',
              prefixIcon: Icon(Icons.account_circle),
              border: border,
            ),
            onSaved: (val) {
              name = val;
            },
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
          ),

          Row(
            children: <Widget>[
              Checkbox(
                onChanged: (_) {
                  setState(() {
                    agree = !agree;
                  });
                },
                value: agree,
              ),
              Flexible(
                child: Text(
                    'By creating account, I agree to Terms & Conditions and Privacy Policy.'),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),

          // signUP button
          SizedBox(
            height: 50,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();

                  AuthenticationHelper()
                      .signUp(email: email!, password: password!)
                      .then((result) {
                    if (result == null) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignInPage()));
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
                      borderRadius: BorderRadius.all(Radius.circular(24.0)))),
              child: Text('Sign Up'),
            ),
          ),
        ],
      ),
    );
  }
}
