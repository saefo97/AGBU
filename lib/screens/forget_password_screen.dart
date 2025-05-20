import 'package:agbu/constants.dart';
import 'package:flutter/material.dart';
import '../components/background_decoration.dart';
import '../components/custom_text_field.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  TextEditingController emailController = TextEditingController();
  bool _isClicked = false;

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
                      Text(
                        "Forget Password?",
                        style: kMainTitleTextStyle.copyWith(
                          fontSize: 32.0
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0,),
                  CustomTextFormFormField(title: 'Email',
                  controller: emailController,

                  ),
                  SizedBox(height: 16.0,),
                  InkWell(
                    borderRadius: _isClicked ?  BorderRadius.circular(30.0) : BorderRadius.circular(20.0),

                    onTap:  _isClicked ? null : (){
                      print(emailController.text.trim());
                      print(emailController.text.isEmpty);
                      setState(() {
                        _isClicked = !_isClicked;
                      });
                    },
                    child: AnimatedContainer(

                      height: 52.0,
                      width: _isClicked ?  220.0  : 150.0,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: _isClicked ?  BorderRadius.circular(30.0) : BorderRadius.circular(20.0),
                        gradient: _isClicked ? LinearGradient(
                          colors: [Colors.green.shade700, Colors.green.shade900],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        )    : kDarkGradiant,
                      ),
                      duration: Duration(

                        milliseconds: 400
                      ),
                      child:  _isClicked ?  Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("Sent!",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22.0
                            ),
                          ),
                          Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 22.0,
                          )
                        ],
                      )  : Text("Send",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22.0
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}