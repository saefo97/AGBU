import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FirebaseFirestore _fireStore =  FirebaseFirestore.instance;
final _auth =  FirebaseAuth.instance.currentUser;

sendMessage(TextEditingController messageController, String userEmail) async {

  final prefs = await SharedPreferences.getInstance();
  String? userName = prefs.getString('userName');
  print(userName);
  if(userName == null || userName.isEmpty || userName==""){
    final uid =  _auth!.uid;
    final doc = await  _fireStore.collection('user').doc(uid).get();
    if (doc.exists &&  doc.data()?['userName'] != null){
       userName =( doc.data()?['userName']).toString();
       prefs.setString("userName",userName);

    }
  }
    _fireStore.collection('messages').doc().set({
      "message": messageController.text.trim(),
      "time": Timestamp.now(),
      "senderEmail": userEmail,
      'userName': userName,
    });


}