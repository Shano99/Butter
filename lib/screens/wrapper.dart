import 'package:butter_app/models/user.dart';
import 'package:butter_app/screens/profile/profile_screen.dart';
import 'package:butter_app/screens/settings/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'authenticate/authenticate.dart';
import 'home/home_screen.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);
    if (user == null) {
      return Authenticate();
    } else
      return MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => HomePage(),
          '/settings': (context) => SettingsScreen(),
          '/profile': (context) => ProfileScreen(),
        },
      );
  }
}
