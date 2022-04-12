import 'package:flutter/material.dart';

class MemberEventButton extends StatelessWidget {
  MemberEventButton({
    required this.child,
    required this.color,
    this.borderRadius : 2.0,
    this.height,
    required this.onPressed,
  }): assert(borderRadius != null) ;
  final Widget child;
  final Color? color;
  final borderRadius;
  final height;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ElevatedButton(
        child: Align(
          alignment: Alignment.centerLeft,
          child: child,
        ),
        style: ButtonStyle(
            backgroundColor:
            MaterialStateProperty.resolveWith((states) => color),
            shape: MaterialStateProperty.resolveWith(
                    (states) => RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(borderRadius),
                    )))),
        onPressed: onPressed,
      ),
    );
  }
}