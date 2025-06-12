import 'package:agbu/components/custom_text_field.dart';
import 'package:agbu/screens/chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/background_decoration.dart';
import '../components/custon_button.dart';
import '../constants.dart';

class PersonalInformation extends StatelessWidget {
  final String email;
  TextEditingController userNameController = TextEditingController();
  final _globalKey = GlobalKey<FormState>();

  PersonalInformation({super.key, required this.email});

  saveUserData(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (_globalKey.currentState!.validate()) {
      FirebaseFirestore.instance.collection('user').doc(user!.uid).set({
        'email': email,
        'userName': userNameController.text.trim(),
        'createdAt': Timestamp.now(),
      });
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder:
              (context) =>
              ChatScreen()
        ),
            (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        Text(
                          "Personal Information",
                          style: kMainTitleTextStyle.copyWith(fontSize: 23.0),
                        ),
                      ],
                    ),

                    SizedBox(height: 16.0),
                    CustomTextFormFormField(
                      controller: userNameController,
                      title: 'User Name',
                      validator: (val) {
                        if (val!.isEmpty || val! == null) {
                          return "Please Enter your User Name";
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 16.0),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: CustomButton(onPressed: () {
                        saveUserData(context);
                      }, title: "Continue"),
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
