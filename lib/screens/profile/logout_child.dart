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
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            SizedBox(
              height: 200,
              width: 200,
              child: Image(
                image: AssetImage('assets/images/logout.png'),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              color: Colors.white,
              elevation: 8,
              child: Text(
                "Log out",
                style: TextStyle(
                  color: Color(0xfff9a825),
                  letterSpacing: 1.5,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'OpenSans',
                ),
              ),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
          ],
        ),
      ),
    );
  }
}
