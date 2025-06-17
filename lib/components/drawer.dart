import 'package:agbu/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:neon_widgets/neon_widgets.dart';
import 'package:provider/provider.dart';

import '../auth_services.dart';
import '../constants.dart';
import '../provider/theme_provider.dart';

class CustomDrawer extends StatefulWidget {

  CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final AuthenticationServices _authenticationServices = AuthenticationServices();
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return  Drawer(
      child: ListView(
        children: [
          CheckboxListTile(value: themeProvider.isDarkMode, onChanged:
              (val){
            themeProvider.toggleTheme();
          },
            title:  Text(
              themeProvider.isDarkMode?   "Light Mode" :  "Dark Mode" ,
            ),
          ),
          SwitchListTile(value: themeProvider.isDarkMode,
              onChanged: (value) {
                themeProvider.toggleTheme();

              },

            title:  Text(
              themeProvider.isDarkMode?   "Light Mode" :  "Dark Mode" ,
            ),
          ),
          ListTile(
            onTap: () async {
              await _authenticationServices.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => WelcomeScreen()),
              );
            },
            title: Text(
             "Log Out",
            ),
            trailing: Icon(Icons.exit_to_app),
          )
        ],
      ),
    );
  }
}
