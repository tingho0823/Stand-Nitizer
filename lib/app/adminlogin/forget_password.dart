import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
final FirebaseAuth _auth = FirebaseAuth.instance;
class ForgetPassword extends StatefulWidget{
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}
class _ForgetPasswordState extends State<ForgetPassword> {

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isLoading = false;

  final database = FirebaseDatabase.instance.reference();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forget Password'),
        elevation: 2.0,
      ),
      body: _buildContext(context),
    );
  }

  Widget _buildContext(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("image1.gif"), fit: BoxFit.cover),
        ),
      padding: EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _emailController,
              validator: (value){
                if(value == null || value.isEmpty){
                  return 'Enter email';
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: 'Email',
                labelText: 'Email',
                prefixIcon: Icon(Icons.mail_outline),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(
              height: 30.0,
            ),
            SizedBox(
              height: 40.0,
              child: ElevatedButton(
                onPressed: (){
                  if(_formKey.currentState!.validate()){
                    FocusScope.of(context).unfocus();
                    _resetPassword();
                  }
                },
                child: (_isLoading)? CircularProgressIndicator(color: Colors.white,) : Text(
                  'Request new password',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    color: Colors.white,
                  ),
                ),
                style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.resolveWith((states) => Colors.indigo),
                    shape: MaterialStateProperty.resolveWith(
                            (states) => RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(50.0),
                            )))),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose(){
    _emailController.clear();
    super.dispose();
  }

  Future<void> _resetPassword() async {

    setState(() {
      _isLoading = true;
    });

    try{
      await _auth.sendPasswordResetEmail(email: _emailController.text);
      printAlertDialogWithExit('Reset Password', 'An email has been sent to ${_emailController.text}');

    }catch(e){
      printAlertDialog('Error', '$e');
    }

    setState(() {
      _isLoading = false;
    });
  }

  void printAlertDialog<string>(String title, String message) {
    showDialog(context: context, builder: (BuildContext context) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, 'Ok'),
          child: Text('Ok'),
        ),
      ],

    ));
  }

  void printAlertDialogWithExit(String title, String message) {
    showDialog(context: context, builder: (BuildContext context) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
          } ,
          child: Text('Ok'),
        ),
      ],

    ));
  }
}