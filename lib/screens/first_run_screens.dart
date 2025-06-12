import 'package:agbu/components/custon_button.dart';
import 'package:agbu/screens/welcome_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FirstRunScreens extends StatelessWidget {
  const FirstRunScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          Center(child: Text("Welcome")),
          Center(child: Text("To")),
          Center(child: Text("Our")),
          FinalPage()
        ],
      ),
    );
  }
}

class FinalPage extends StatelessWidget {
  const FinalPage({super.key});

  @override
  Widget build(BuildContext context) {
 return   Column(
   children: [
     Center(child: Text("App")),
     CustomButton(onPressed: (){
Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>WelcomeScreen()));
     }, title: "Next")
   ],
 );
  }
}
