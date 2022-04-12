import 'package:testtt/Common_widget/custome_elevated%20button.dart';
import 'package:flutter/material.dart';

class SSignInButton extends CustomRaisedButton {
  SSignInButton({
    required String assetName,
    required String text,
    required color,
    required tcolor,
    required onPressed,
    required style,
  }) : super(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(assetName),
              Text(
                text,
                style: TextStyle(color: tcolor, fontSize: 20.0),
              ),
              Opacity(opacity: 0.0, child: Image.asset('facebook-logo.png')),
            ],
          ),
          onPressed: onPressed,
          color: color,
          tcolor: tcolor,
          style: style,
          borderRadius: 15.0,
        );
}
