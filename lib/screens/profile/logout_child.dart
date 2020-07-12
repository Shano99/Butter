import 'package:butter_app/services/auth.dart';
import 'package:flutter/material.dart';

class LogoutChild extends StatefulWidget {
  @override
  _LogoutChildState createState() => _LogoutChildState();
}

class _LogoutChildState extends State<LogoutChild> {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: RaisedButton(
          child: Text("Log out"),
          onPressed: () async {
            await _auth.signOut();
          },
        ),
      ),
    );
  }
}
