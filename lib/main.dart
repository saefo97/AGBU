import 'package:agbu/components/loading_screen.dart';
import 'package:agbu/screens/chat_screen.dart';
import 'package:agbu/screens/personal_information.dart';
import 'package:agbu/screens/welcome_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  //TODO : Authchange
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'times'),
      debugShowCheckedModeBanner: false,
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final user = snapshot.data;
            if (user == null) {
              return WelcomeScreen();
            } else {
              return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                future:
                    FirebaseFirestore.instance
                        .collection('user')
                        .doc(user.uid)
                        .get(),
                builder: (context, userSnapshot) {
                  if (userSnapshot.connectionState == ConnectionState.waiting) {
                    return LoadingScreen();
                  }
                  if (userSnapshot.hasError ||
                      !userSnapshot.hasData ||
                      userSnapshot.data == null) {
                    return Center(child: Text("حدث خطأ في تحميل البيانات"));
                  }

                  final userData = userSnapshot.data!.data();
                  if (userData?['userName'] == null ||
                      !userSnapshot.data!.exists)
                    return PersonalInformation(email: user.email!);
                  else
                    return ChatScreen();
                },
              );
            }
          }
          return LoadingScreen();
        },
      ),
    );
  }
}
