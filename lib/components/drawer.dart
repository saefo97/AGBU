import 'package:flutter/material.dart';
import 'package:neon_widgets/neon_widgets.dart';

import '../auth_services.dart';
import '../constants.dart';

class CustomDrawer extends StatelessWidget {
  final AuthenticationServices _authenticationServices = AuthenticationServices();

  CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return  Drawer(
      width: 200,
      child: ListView(
        children: [
          ListTile(
            onTap: () {
              _authenticationServices.signOut();

            },
            title: NeonText(
              text: "Log Out",
              spreadColor: kDarkBlue2,
              blurRadius: 15,
              textSize: 28.0,
              textColor: Colors.blue.shade300,
            ),
            trailing: Icon(Icons.exit_to_app),
          ),
        ],
      ),
    );
  }
}
