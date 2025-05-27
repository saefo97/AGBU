import 'package:agbu/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          kLightBlue1,
          kDarkBlue2
        ],
        begin: Alignment.topCenter,
          end: Alignment.bottomCenter

        )
      ),
      child: SpinKitSpinningLines(color: Colors.white,
      size: 140,
        lineWidth: 4,

      ),
    );
  }
}
