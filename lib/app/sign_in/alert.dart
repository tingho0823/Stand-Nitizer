import 'package:flutter/material.dart';

showAlertDialog2({
  required BuildContext context,
  required String button,
  required String title,
  required String message,
}) {
  bool result;

  // set up the button
  Widget okButton = TextButton(
    child: Text(button),
    onPressed: () {
      Navigator.pop(context);
      result = true;
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(message),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
