import 'package:butter_app/models/user.dart';
import 'package:butter_app/services/auth.dart';
import 'package:butter_app/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'award_child.dart';
import 'history_services/history_child.dart';
import 'map_service/map_child.dart';
import 'package:butter_app/shared/constants.dart';

//TODO:get live location
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
    final user = Provider.of<User>(context);
    void showSettings() {
      Navigator.pushNamed(context, "/settings");
    }

    void showProfile() {
      Navigator.pushNamed(context, "/profile");
    }

    return StreamProvider<List<UserLocation>>.value(
      value: DatabaseService().locations,
      child: StreamProvider<List<HistoryData>>.value(
        value: DatabaseService(uid: user.uid).historyData,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30),
              ),
            ),
            backgroundColor: PrimaryColor,
            title: Text(
              "Home",
              style: kLabelStyle,
            ),
            elevation: 0,
            actions: <Widget>[
              IconButton(
                //profile but signout now
                onPressed: () {
                  //goto bottom sheet profile options
                  showProfile();
                },
                icon: Icon(
                  Icons.person,
                  color: Colors.black,
                ),
              ),
              IconButton(
                //Settings
                onPressed: () {
                  //goto bottom sheet settings options
                  showSettings();
                },

                icon: Icon(
                  Icons.settings,
                  color: Colors.black,
                ),
              )
            ],
          ),
          body: _children[_currentIndex],
          bottomNavigationBar: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
            child: BottomNavigationBar(
              onTap: onTabTapped,
              backgroundColor: PrimaryColor,
              fixedColor: Colors.black,
              currentIndex: _currentIndex,
              items: [
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.place,
                      color: Colors.black,
                    ),
                    title: Text("Map")),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.stars,
                      color: Colors.black,
                    ),
                    title: Text("Award")),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.favorite,
                      color: Colors.black,
                    ),
                    title: Text("History")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
