
import 'package:flutter/material.dart';
import 'package:testtt/Common_widget/custome_elevated button.dart';

class SignInButton extends CustomRaisedButton {
  SignInButton({
    required String text,
    required color,
    required tcolor,
    required onPressed,
    required style,
  }) : super(
    child: Text(text),
    onPressed: onPressed,
    color: color,
    tcolor: tcolor,
    style: style,
    borderRadius: 15.0,
  );
}
