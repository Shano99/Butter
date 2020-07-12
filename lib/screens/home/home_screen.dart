import 'package:butter_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'award_child.dart';
import 'history_child.dart';
import 'map_child.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _children = [MapChild(), AwardChild(), HistoryChild()];
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      print(_currentIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    void showSettings() {
      Navigator.pushNamed(context, "/settings");
    }

    void showProfile() {
      Navigator.pushNamed(context, "/profile");
    }

    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        title: Text("Home"),
        elevation: 0,
        actions: <Widget>[
          IconButton(
            //profile but signout now
            onPressed: () {
              //goto bottom sheet profile options
              showProfile();
            },
            icon: Icon(Icons.person),
          ),
          IconButton(
            //Settings
            onPressed: () {
              //goto bottom sheet settings options
              showSettings();
            },

            icon: Icon(Icons.settings),
          )
        ],
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.place), title: Text("Map")),
          BottomNavigationBarItem(
              icon: Icon(Icons.stars), title: Text("Award")),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), title: Text("History")),
        ],
      ),
    );
  }
}
