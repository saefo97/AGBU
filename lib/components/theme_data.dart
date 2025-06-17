import 'package:flutter/material.dart';

import '../constants.dart';

ThemeData darkMode =


ThemeData.dark(

).copyWith(
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
          borderSide: BorderSide(
              color: Colors.purpleAccent,
              width: 2
          )
      ),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(
              color: kDarkBlue1,
              width: 3
          )
      ),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
          borderSide: BorderSide(
              color: Colors.red,
              width: 2
          )
      ),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(
              color: Colors.red,
              width: 3
          )
      ),
    ),
);


ThemeData lightTheme = ThemeData(
  inputDecorationTheme: InputDecorationTheme(
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6.0),
        borderSide: BorderSide(
            color: Colors.blue.shade300,
            width: 2
        )
    ),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(
            color: kDarkBlue1,
            width: 3
        )
    ),
    errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6.0),
        borderSide: BorderSide(
            color: Colors.red,
            width: 2
        )
    ),
    focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(
            color: Colors.red,
            width: 3
        )
    ),
  )
);
