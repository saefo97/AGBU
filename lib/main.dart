import 'package:agbu/screens/chat_screen.dart';
import 'package:agbu/screens/first_run_screens.dart';
import 'package:agbu/screens/personal_information.dart';
import 'package:agbu/screens/welcome_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'components/loading_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<String?> _getUserNameFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userName');
  }

  bool _isFirstRun=false;
  Future<bool?> isFirstRun() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isFirstRun = prefs.getBool('firstTime') ?? false;
    });
    if (_isFirstRun == false) {
      prefs.setBool('firstTime', true);
    }

    print(_isFirstRun);
    return prefs.getBool('firstTime');
  }

  @override
  void initState() {
    isFirstRun();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'times'),
      debugShowCheckedModeBanner: false,
      home:
          !_isFirstRun
              ? FirstRunScreens()
              : StreamBuilder<User?>(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    final user = snapshot.data;
                    if (user == null) {
                      return WelcomeScreen();
                    } else {
                      return FutureBuilder<String?>(
                        future: _getUserNameFromPrefs(),
                        builder: (context, prefsSnapshot) {
                          if (prefsSnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return LoadingScreen();
                          }
                          final userName = prefsSnapshot.data;
                          if (userName!.isNotEmpty || userName != null) {
                            return ChatScreen();
                          }
                          return FutureBuilder<
                            DocumentSnapshot<Map<String, dynamic>>
                          >(
                            future:
                                FirebaseFirestore.instance
                                    .collection('user')
                                    .doc(user.uid)
                                    .get(),
                            builder: (context, userSnapshot) {
                              if (userSnapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return LoadingScreen();
                              }
                              if (userSnapshot.hasError ||
                                  !userSnapshot.hasData ||
                                  userSnapshot.data == null) {
                                return Center(
                                  child: Text("حدث خطأ في تحميل البيانات"),
                                );
                              }

                              final userData = userSnapshot.data!.data();
                              if (userData?['userName'] == null ||
                                  !userSnapshot.data!.exists)
                                return PersonalInformation(email: user.email!);
                              else
                                return ChatScreen();
                            },
                          );
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
