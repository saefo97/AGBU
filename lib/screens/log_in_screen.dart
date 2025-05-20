import 'package:agbu/constants.dart';
import 'package:agbu/screens/chat_screen.dart';
import 'package:agbu/screens/forget_password_screen.dart';
import 'package:flutter/material.dart';
import '../components/background_decoration.dart';
import '../components/custom_text_field.dart';
import '../components/custon_button.dart';


class LogInPage extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  LogInPage({super.key});

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
                      Text("Sign In", style: kMainTitleTextStyle),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  CustomTextFormFormField(title: 'Email',
                  controller: emailController,
                  ),
                  SizedBox(height: 8.0),
                  CustomTextFormFormField(
                      isPassword: true,
                      controller: passwordController,
                      title: 'Password'),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ForgetPasswordScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'Forget Password?',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Hero(
                    tag: "Sign In",

                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: CustomButton(onPressed: () {
   Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatScreen()))  ;                   
                      }, title: "Sign In"),
                    ),
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
