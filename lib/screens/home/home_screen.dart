//jus for trial
import 'package:butter_app/services/auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blue[50],
        appBar: AppBar(
          backgroundColor: Colors.blue[400],
          title: Text("Home(trial)"),
          elevation: 0,
          actions: <Widget>[
            FlatButton.icon(
                onPressed: () async {
                  await _auth.signOut();
                },
                icon: Icon(Icons.person),
                label: Text("logout"))
          ],
        ),
      ),
    );
  }
}
