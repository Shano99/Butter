import 'package:butter_app/screens/authenticate/signup_screen.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignin = true;
  void toggleView() {
    setState(() {
      showSignin = !showSignin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignin)
      return LoginScreen(toggleView: toggleView);
    else
      return SignUpScreen(toggleView: toggleView);
  }
}
