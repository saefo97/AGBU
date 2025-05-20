import 'package:flutter/material.dart';
import 'package:neon_widgets/neon_widgets.dart';
import '../components/custom_appbar.dart';
import '../constants.dart';

class ChatScreen extends StatelessWidget{
  ChatScreen({super.key});

List <String> message = [
  "Hello HI hgnvn hfghfg hfgh gfh gfh fgh gfhfghfghgf gfhgfhgfhfhgf  gfhgfhgfhgfhgfhfgh gfhgfhgfhgfhfghfg ",
  "Byeo HI hgnvnhfghfg hfgh gfhgfh fghgfhfghfghgf gfhgfhgfhfhgf  g"
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title : "AGBU"),
      endDrawer: Drawer(
        width: 200,
        child: ListView(

          children: [
            ListTile(
              onTap:(){

      },
              title: NeonText(
                text: "Log Out",
                spreadColor: kDarkBlue2,
                blurRadius: 15,
                textSize: 28.0,
                textColor: Colors.blue.shade300,
              ),
              trailing: Icon(Icons.exit_to_app),
            )
          ],
        )
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: message.length,
        itemBuilder: (context, index) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: index%2==0 ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width*2/3
                ),
                padding: EdgeInsets.symmetric(horizontal: 8.0,
                vertical: 4.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(18.0),
                    bottomLeft: Radius.circular(18.0),
                    topRight: index %2 ==0 ? Radius.circular(0.0):  Radius.circular(18.0),
                    topLeft: index %2 ==1 ? Radius.circular(0.0):  Radius.circular(18.0),
                  ),
                  color: index %2 ==0 ? kLightBlue1 : kDarkBlue1
                ),
                child: Text(message[index],
                style: TextStyle(

                  color: index %2 ==0 ? Colors.black : Colors.white,
                  fontSize: 18.0,
                ),
                ),
              ),
            ),
            SizedBox(height: 8.0,)
          ],
        );
      },),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0,
            vertical: 8.0
          ),
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(30.0)
          ),

          child: Row(
            children: [
              Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      focusedBorder: InputBorder.none,
                      hintText: "Message",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 20
                      )
                    ),
                  )),
              IconButton(
                padding: EdgeInsets.all(12.0),
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Colors.red;
                    }
                    return kDarkBlue2; // اللون الافتراضي
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

