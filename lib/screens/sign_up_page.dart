import 'package:agbu/components/loading_screen.dart';
import 'package:agbu/constants.dart';
import 'package:agbu/screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../auth_services.dart';
import '../components/background_decoration.dart';
import '../components/custom_text_field.dart';
import '../components/custon_button.dart';
import 'log_in_screen.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final AuthenticationServices _authenticationServices =
      AuthenticationServices();
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  final _globalKey = GlobalKey<FormState>();
  TextEditingController confirmPasswordController = TextEditingController();
  bool isLoading = false;

  signUp() async {
    if (_globalKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      String? errorMessage = await _authenticationServices.signUp(
        emailController.text.trim(),
        passwordController.text.trim(),
      );
      setState(() {
        isLoading = false;
      });
      if (errorMessage == "Please Check Your Email") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LogInPage(email: emailController.text.trim()),
          ),
        );
        showErrorMessage(errorMessage!);
      } else {
        showErrorMessage(errorMessage!);
      }
    }
  }

  void showErrorMessage(String errorMessage) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(errorMessage)));
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
                            Text("Sign Up", style: kMainTitleTextStyle),
                          ],
                        ),

                        SizedBox(height: 16.0),
                        CustomTextFormFormField(
                          title: 'Email',
                          validator: (val) {
                            if (val!.isEmpty || val! == null) {
                              return "Please Enter your Email";
                            }
                            return null;
                          },
                          controller: emailController,
                        ),
                        SizedBox(height: 8.0),

                        CustomTextFormFormField(
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
                        SizedBox(height: 8.0),

                        CustomTextFormFormField(
                          validator: (val) {
                            if (val!.isEmpty || val! == null) {
                              return "Please Enter your Confirmed Password";
                            } else if (passwordController.text.trim() !=
                                confirmPasswordController.text.trim()) {
                              return "Password didn't Match";
                            }
                            return null;
                          },
                          isPassword: true,

                          title: 'Confirm Password',
                          controller: confirmPasswordController,
                        ),

                        SizedBox(height: 16.0),
                        Hero(
                          tag: "Sign Up",
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: CustomButton(
                              onPressed: () {
                                signUp();
                              },
                              title: "Sign Up",
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
