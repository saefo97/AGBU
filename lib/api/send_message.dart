import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final FirebaseFirestore _fireStore =  FirebaseFirestore.instance;
final _auth =  FirebaseAuth.instance.currentUser;

sendMessage(TextEditingController messageController, String userEmail) async {
  final uid =  _auth!.uid;
  final doc = await  _fireStore.collection('user').doc(uid).get();
  if (doc.exists &&  doc.data()?['userName'] != null){
    final userName = doc.data()?['userName'];
    _fireStore.collection('messages').doc().set({
      "message": messageController.text.trim(),
      "time": Timestamp.now(),
      "senderEmail": userEmail,
      'userName': userName,
    });
  }

}