import 'package:agbu/components/fade_animation.dart';
import 'package:agbu/constants.dart';
import 'package:agbu/screens/chat_screen.dart';
import 'package:agbu/screens/forget_password_screen.dart';
import 'package:agbu/screens/personal_information.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../auth_services.dart';
import '../components/background_decoration.dart';
import '../components/custom_text_field.dart';
import '../components/custon_button.dart';
import '../components/loading_screen.dart';

class LogInPage extends StatefulWidget {
  LogInPage({super.key, required this.email});
  final String email;

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final AuthenticationServices _authenticationServices =
      AuthenticationServices();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  final _globalKey = GlobalKey<FormState>();

  signIn() async {
    if (_globalKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      String? errorMessage = await _authenticationServices.signIn(
        emailController.text.trim(),
        passwordController.text.trim(),
      );

      if (errorMessage == null) {
        final uid = FirebaseAuth.instance.currentUser?.uid;
        final doc =
            await FirebaseFirestore.instance.collection('user').doc(uid).get();
        if (!doc.exists || doc['userName'] == null) {
          setState(() {
            isLoading = false;
          });
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder:
                  (context) =>
                      PersonalInformation(email: emailController.text.trim()),
            ),
            (route) => false,
          );
        } else if (doc.exists) {
          final prefs = await SharedPreferences.getInstance();
          prefs.setString("userName", (doc['userName']).toString());
          setState(() {
            isLoading = false;
          });
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => ChatScreen()),
            (route) => false,
          );
        }
      } else {
        setState(() {
          isLoading = false;
        });
        showErrorMessage(errorMessage);
      }
    }
  }

  void showErrorMessage(String errorMessage) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(errorMessage)));
  }

  @override
  void initState() {
    emailController.text = widget.email;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? LoadingScreen()
        : Scaffold(
          body: Form(
            key: _globalKey,
            child: Stack(
              children: [
                BackGroundDecoration(),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Hero(
                              tag: "logo",
                              child: Image.asset(
                                'assets/images/logo.png',
                                height: 80.0,
                              ),
                            ),
                            SizedBox(width: 32.0),
                            FadeAnimation(

                                delay: 250,
                                child: Text("Sign In", style: kMainTitleTextStyle)),
                          ],
                        ),

                        SizedBox(height: 16.0),
                        FadeAnimation(

                          delay: 500,                          child: CustomTextFormFormField(
                            title: 'Email',
                            validator: (val) {
                              if (val!.isEmpty || val! == null) {
                                return "Please Enter your Email";
                              }
                              return null;
                            },
                            controller: emailController,
                          ),
                        ),
                        SizedBox(height: 8.0),

                        FadeAnimation(

                          delay: 750,                          child: CustomTextFormFormField(
                            validator: (val) {
                              if (val!.isEmpty || val! == null) {
                                return "Please Enter your Password";
                              } else if ((passwordController.text.trim()).length <
                                  6) {
                                return "Weak Password";
                              }
                              return null;
                            },
                            isPassword: true,
                            title: 'Password',
                            controller: passwordController,
                          ),
                        ),

                        SizedBox(height: 16.0),
                        FadeAnimation(

                          delay: 1000,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: CustomButton(
                              onPressed: () {
                                print(emailController.text);
                                signIn();
                              },
                              title: "Sign In",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
  }
}
