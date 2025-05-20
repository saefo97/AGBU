import 'package:flutter/material.dart';

Color kLightBlue1 = Colors.blue.shade300;
Color kLightBlue2 = Colors.blue.shade500;
Color kDarkBlue1 = Colors.blue.shade700;
Color kDarkBlue2 = Colors.blue.shade900;

LinearGradient kLightGradiant = LinearGradient(
  colors: [kLightBlue1, kLightBlue2],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);

LinearGradient kDarkGradiant =  LinearGradient(
  colors: [kDarkBlue1, kDarkBlue2],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);

TextStyle kMainTitleTextStyle =TextStyle(
    fontSize: 48.0,
    fontWeight: FontWeight.w500,
    letterSpacing: 2.0,
    color: kDarkBlue1
);