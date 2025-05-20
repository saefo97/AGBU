
import 'package:flutter/material.dart';

import '../constants.dart';

class BackGroundDecoration extends StatelessWidget {
  const BackGroundDecoration({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          Positioned(
            right: 0.0,
            top: 0.0,
            child: Container(
              width: MediaQuery.of(context).size.width * 1 / 2,
              height: MediaQuery.of(context).size.width / 2,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black87,
                    spreadRadius: 2,
                    blurRadius: 4,
                  ),
                ],
                gradient: kLightGradiant,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(360.0),
                ),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 2 / 3,
            height: MediaQuery.of(context).size.width * 2 / 3,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black87,
                  spreadRadius: 3,
                  blurRadius: 7,
                ),
              ],
              gradient:kDarkGradiant,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(360.0),
              ),
            ),
          ),
          Positioned(
            left: 70.0,
            bottom: 70.0,
            child: Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 4),
                    color: Colors.black87,
                    spreadRadius: 3,
                    blurRadius: 7,
                  ),
                ],
                gradient: kLightGradiant,
                borderRadius: BorderRadius.circular(360.0),
              ),
            ),
          ),
          Positioned(
            right: 50.0,
            bottom: 210.0,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 3.5),

                    color: Colors.black87,
                    spreadRadius: 2,
                    blurRadius: 4,
                  ),
                ],
                gradient: kDarkGradiant,
                borderRadius: BorderRadius.circular(360.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}