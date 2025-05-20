import 'package:agbu/constants.dart';
import 'package:agbu/screens/sign_up_page.dart';
import 'package:flutter/material.dart';
import '../components/background_decoration.dart';
import '../components/custon_button.dart';
import 'log_in_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';


class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackGroundDecoration(),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Hero(
                    tag: "logo",
                    child: Image.asset('assets/images/logo.png',
                      height: 180.0,
                    ),
                  ),
                  SizedBox(height: 32.0,),

                  DefaultTextStyle(


                               style: kMainTitleTextStyle.copyWith(
                    fontSize: 24,
                                 fontFamily: 'times'
                  ),
                    child: AnimatedTextKit(

                      animatedTexts: [
                        TypewriterAnimatedText('Welcome to AGBU Chat App!',
                          speed: const Duration(milliseconds: 100),


                        ),
                      ],
                      onTap: () {
                        print("Tap Event");
                      },
                    ),
                  ),
                  SizedBox(height: 32.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Hero(
                        tag: "Sign In",
                        child: SizedBox(
                          child: CustomButton(onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>LogInPage()));
                          }, title: "Sign In"),
                        ),
                      ),

                      Hero(
                        tag: "Sign Up",
                        child: SizedBox(
                          child: CustomButton(onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpPage()));

                          }, title: "Sign Up"),
                        ),
                      ),
                    ],
                  ),

                ]

              ),
            ),
          ),
        ],
      ),
    );
  }
}