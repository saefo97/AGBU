import 'package:agbu/constants.dart';
import 'package:agbu/screens/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/background_decoration.dart';
import '../components/custon_button.dart';
import 'log_in_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation? colorTween;
  Animation<Offset>? offsetImage;
  Animation<double>? fadeImage;
  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    colorTween = ColorTween(
      begin: kDarkBlue2,
      end: Colors.white,
    ).animate(_animationController!);
    offsetImage = Tween<Offset>(
      begin: Offset(0, -0.2),
      end: Offset(0.0, 0.0),
    ).animate(_animationController!);
    fadeImage = Tween<double>(
      end: 1,
      begin: 0,
    ).animate(_animationController!);
    _animationController?.forward();
    _animationController?.addListener(() {
      setState(() {
        print(colorTween!.value);
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: colorTween?.value,
      body: Stack(
        children: [
          BackGroundDecoration(),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FadeTransition(
                    opacity: fadeImage!,
                    child: SlideTransition(
                      position: offsetImage!,
                      child: Hero(
                        tag: "logo",
                        child: Image.asset(
                          'assets/images/logo.png',
                          height: 180.0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 32.0),

                  DefaultTextStyle(
                    style: kMainTitleTextStyle.copyWith(
                      fontSize: 24,
                      fontFamily: 'times',
                    ),
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          'Welcome to AGBU Chat App!',
                          speed: const Duration(milliseconds: 100),
                        ),
                      ],
                      onTap: () {
                        print("Tap Event");
                      },
                    ),
                  ),
                  SizedBox(height: 32.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Hero(
                        tag: "Sign In",
                        child: SizedBox(
                          child: CustomButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LogInPage(email: ''),
                                ),
                              );
                            },
                            title: "Sign In",
                          ),
                        ),
                      ),

                      Hero(
                        tag: "Sign Up",
                        child: SizedBox(
                          child: CustomButton(
                            onPressed: () async {
                              final prefs =
                                  await SharedPreferences.getInstance();
                              prefs.remove('firstTime');
                              print(
                                "***************************************************************",
                              );
                              print("cache cleared");
                              print(
                                "***************************************************************",
                              );
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignUpPage(),
                                ),
                              );
                            },
                            title: "Sign Up",
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
