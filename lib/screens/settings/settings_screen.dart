import 'package:butter_app/screens/settings/about_child.dart';
import 'package:butter_app/screens/settings/privacy_child.dart';
import 'package:butter_app/shared/constants.dart';
import 'package:flutter/material.dart';

import 'account_child.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  int _currentIndex = 0;

  final List<Widget> _children = [AccountChild(), PrivacyChild(), AboutChild()];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      print(_currentIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        backgroundColor: PrimaryColor,
        title: Text("Settings"),
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        child: BottomNavigationBar(
          backgroundColor: PrimaryColor,
          fixedColor: Colors.black,
          onTap: onTabTapped,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.account_box), title: Text("Account")),
            BottomNavigationBarItem(
                icon: Icon(Icons.lock), title: Text("Privacy")),
            BottomNavigationBarItem(
                icon: Icon(Icons.help_outline), title: Text("About")),
          ],
        ),
      ),
    );
  }
}
