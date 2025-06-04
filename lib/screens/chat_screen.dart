import 'package:agbu/components/loading_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../api/send_message.dart';
import '../auth_services.dart';
import '../components/custom_appbar.dart';
import '../components/drawer.dart';
import '../constants.dart';

class ChatScreen extends StatefulWidget {

  ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final FirebaseFirestore _fireStore =  FirebaseFirestore.instance;

  TextEditingController messageController = TextEditingController();

  String? userEmail;
  getSenderEmail() async {
    setState(()async {
      userEmail = await
      (FirebaseAuth.instance.currentUser?.email).toString();
    });
  }
  @override
  void initState() {
    getSenderEmail();
    super.initState();
  }
  sendMessage(TextEditingController messageController, String userEmail){
    _fireStore.collection('messages').doc().set({
      "message": messageController.text.trim(),
      "time": Timestamp.now(),
      "senderEmail": userEmail,
    });
    messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    getSenderEmail();
    return Scaffold(
      appBar: CustomAppBar(title: "AGBU"),
      endDrawer:CustomDrawer(),
      body: StreamBuilder<QuerySnapshot>(
        stream:
        _fireStore
                .collection('messages')
                .orderBy('time')
                .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.active) {
            return LoadingScreen();
          }
          print(snapshot.hasData);
          if (snapshot.data!.docs.isEmpty) {
            return Center(child: Text("No Messages yet!"));
          }
          var data = snapshot.data?.docs;
          print(data);
          return ListView.builder(
            padding: EdgeInsets.all(16.0),
            itemCount: data?.length,
            itemBuilder: (context, index) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment:
                    (userEmail == data?[index]['senderEmail'])
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 2 / 3,
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(18.0),
                          bottomLeft: Radius.circular(18.0),
                          topRight:
                          (userEmail == data?[index]['senderEmail'])
                                  ? Radius.circular(0.0)
                                  : Radius.circular(18.0),
                          topLeft:
                          (userEmail != data?[index]['senderEmail'])
                                  ? Radius.circular(0.0)
                                  : Radius.circular(18.0),
                        ),
                        color: (userEmail == data?[index]['senderEmail'])? kLightBlue1 : kDarkBlue1,
                      ),
                      child: Text(
                        data?[index]['message'],
                        style: TextStyle(
                          color: (userEmail == data?[index]['senderEmail']) ? Colors.black : Colors.white,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8.0),
                ],
              );
            },
          );
        },
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(30.0),
          ),

          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: messageController,
                  decoration: InputDecoration(
                    focusedBorder: InputBorder.none,
                    hintText: "Message",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 20),
                  ),
                ),
              ),
              IconButton(
                padding: EdgeInsets.all(12.0),

                onPressed: (){
                  sendMessage(
                      messageController,userEmail!
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>((
                    states,
                  ) {
                    if (states.contains(MaterialState.pressed)) {
                      return Colors.red;
                    }
                    return kDarkBlue2;
                  }),
                ),
                color: Colors.white,
                icon: Icon(Icons.send),
              ),
            ],
          ),
        ),
      ),
    );
  }
}