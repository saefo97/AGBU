

import 'package:flutter/material.dart';

import '../constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
  final String title;
  CustomAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 6.0,
      automaticallyImplyLeading: false,
      iconTheme: IconThemeData(color: Colors.white),
      backgroundColor: kDarkBlue2,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(width: 6.0),
          Hero(
            tag: "logo",
            child: Image.asset(
              'assets/images/logo.png',
              height: 48.0,
            ),
          ),
          SizedBox(width: 6.0),
          Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
