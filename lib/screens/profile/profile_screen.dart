import 'package:butter_app/screens/profile/logout_child.dart';
import 'package:butter_app/screens/profile/score_child.dart';
import 'package:butter_app/screens/profile/stats_child.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _currentIndex = 0;

  final List<Widget> _children = [StatsChild(), ScoreChild(), LogoutChild()];

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
        title: Text("Profile"),
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.assessment), title: Text("Stats")),
          BottomNavigationBarItem(
              icon: Icon(Icons.insert_emoticon), title: Text("Score")),
          BottomNavigationBarItem(
              icon: Icon(Icons.directions_run), title: Text("Logout")),
        ],
      ),
    );
  }
}
