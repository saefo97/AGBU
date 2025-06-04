import 'package:agbu/components/loading_screen.dart';
import 'package:agbu/screens/chat_screen.dart';
import 'package:agbu/screens/welcome_screen.dart';
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
        theme: ThemeData(
          fontFamily: 'times'
        ),
        debugShowCheckedModeBanner: false,
        home: StreamBuilder<User?>
          (stream:FirebaseAuth.instance.authStateChanges(),

            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.active){
                User? user = snapshot.data;
                if(user == null){
                  return WelcomeScreen();
                }else{
                  return ChatScreen();
                }
              }
              return LoadingScreen();
            },

        )

    );
  }
}

