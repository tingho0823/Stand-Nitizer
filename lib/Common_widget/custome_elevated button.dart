
import 'package:flutter/material.dart';

class CustomRaisedButton extends StatelessWidget {
  CustomRaisedButton({
    required this.child,
    required this.color,
    required this.borderRadius,
    required this.onPressed,
    required this.style,
    required this.tcolor, tsize,
  });
  final Widget child;
  final Color color;
  final Color tcolor;
  final double borderRadius;
  final VoidCallback onPressed;
  final double style;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:50.0,
      child: ElevatedButton(
        child: child,
        style: ElevatedButton.styleFrom(
          primary: color, // background
          onPrimary: tcolor,
          textStyle: TextStyle(fontSize:style),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(borderRadius),
              )),
        ), // foreground
        onPressed: onPressed,
      ),
    );
  }
}
