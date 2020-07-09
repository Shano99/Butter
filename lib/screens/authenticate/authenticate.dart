import 'package:butter_app/screens/authenticate/signup_screen.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  @override
  Widget build(BuildContext context) {
    return LoginScreen();
  }
}
