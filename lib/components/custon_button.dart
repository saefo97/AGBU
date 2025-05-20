

import 'package:flutter/material.dart';

import '../constants.dart';

class CustomButton extends StatelessWidget {
  final String title;
  void Function()? onPressed;
  CustomButton({
    required this.onPressed,
    super.key, required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(60),
          gradient:title == "Sign In" ? kLightGradiant : kDarkGradiant
      ),
      child: MaterialButton(onPressed: onPressed,
        height: 52,
        minWidth: 160,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(60.0)
        ) ,
        child:  Text(title,
          style: TextStyle(
              color: Colors.white,
              fontSize: 22.0
          ),
        ),
        color: Colors.transparent,
        elevation: 0.0,
      ),
    );
  }
}