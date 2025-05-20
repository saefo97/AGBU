import 'package:agbu/constants.dart';
import 'package:flutter/material.dart';
import '../components/background_decoration.dart';
import '../components/custom_text_field.dart';
import '../components/custon_button.dart';

class SignUpPage extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  SignUpPage({super.key});

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
                        child: Image.asset('assets/images/logo.png',
                          height: 80.0,
                        ),
                      ),SizedBox(width: 32.0,),
                      Text(
                        "Sign Up",
                        style: kMainTitleTextStyle,
                      ),
                    ],
                  ),

                  SizedBox(height: 16.0,),
                  CustomTextFormFormField(title: 'Email',
                  controller: emailController,),
                  SizedBox(height: 8.0,),

                  CustomTextFormFormField(
                    isPassword: true,
                    title: 'Password',
                  controller: passwordController,),
                  SizedBox(height: 8.0,),

                  CustomTextFormFormField(
                    isPassword: true,

                    title: 'Confirm Password',
                  controller:
                    confirmPasswordController,),
                  

                  
                  SizedBox(height: 16.0,),
                  Hero(
                    tag: "Sign Up",
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                      child: CustomButton(
                        onPressed: (){},
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
    );
  }
}