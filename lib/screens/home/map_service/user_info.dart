import 'package:butter_app/services/database_service.dart';
import 'package:butter_app/shared/loading.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:butter_app/models/user.dart';

class UserInfo extends StatefulWidget {
  final String uidt;
  final String giveruid;
  UserInfo({this.uidt, this.giveruid});
  _getuid() {
    // print(this.uidt);
    return uidt;
  }

  _getGiverUid() {
    return giveruid;
  }

  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  // final String _bio = "\"Hello. I am from Chennai and love to party.\"";

  int count = 0;
  DateTime prevAwardTime;
  DateTime presAwardTime;
  Duration fixedTime = new Duration(hours: 24);
  //TODO: change duration time
  Color btnColor = Colors.yellow[800];
  static int _points = -1;
  static int _rate = -1;

  Widget _buildCoverImage(Size screenSize) {
    return Container(
      height: screenSize.height / 2.6,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/yellow.png"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildProfileImage(String photourl) {
    return Center(
      child: Container(
        width: 140.0,
        height: 140.0,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: photourl.isEmpty
                ? AssetImage("assets/images/yellow.png")
                : NetworkImage(photourl),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(80.0),
          border: Border.all(
            color: Colors.white,
            width: 10.0,
          ),
        ),
      ),
    );
  }

  Widget _buildFullName(String name) {
    TextStyle _nameTextStyle = TextStyle(
      fontFamily: 'Roboto',
      color: Colors.black,
      fontSize: 28.0,
      fontWeight: FontWeight.w700,
    );

    return Text(
      name,
      style: _nameTextStyle,
    );
  }

  Widget _buildStatus(BuildContext context, String nickname) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Text(
        nickname,
        style: TextStyle(
          fontFamily: 'Spectral',
          color: Colors.black,
          fontSize: 20.0,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, int count) {
    TextStyle _statLabelTextStyle = TextStyle(
//      fontFamily: 'Roboto',
      color: Colors.black,
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
    );

    TextStyle _statCountTextStyle = TextStyle(
      color: Colors.black,
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          count.toString(),
          style: _statCountTextStyle,
        ),
        Text(
          label,
          style: _statLabelTextStyle,
        ),
      ],
    );
  }

  Widget _buildStatContainer(String age) {
    return Container(
      height: 60.0,
      margin: EdgeInsets.only(top: 8.0),
      decoration: BoxDecoration(
        color: Color(0xfff9a825),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _buildStatItem("Age", int.parse(age)),
          _buildStatItem("Points", _points),
          _buildStatItem("Rate", _rate.round()),
        ],
      ),
    );
  }

//  Widget _buildBio(BuildContext context) {
//    TextStyle bioTextStyle = TextStyle(
//      fontFamily: 'Spectral',
//      fontWeight: FontWeight.w400, //try changing weight to w500 if not thin
//      fontStyle: FontStyle.italic,
//      color: Color(0xFF799497),
//      fontSize: 16.0,
//    );

//    return Container(
//      color: Theme.of(context).scaffoldBackgroundColor,
//      padding: EdgeInsets.all(8.0),
//      child: Text(
//        _bio,
//        textAlign: TextAlign.center,
//        style: bioTextStyle,
//      ),
//    );
//  }

  Widget _buildSeparator(Size screenSize) {
    return Container(
      width: screenSize.width / 1.6,
      height: 2.0,
      color: Colors.black54,
      margin: EdgeInsets.only(top: 4.0),
    );
  }

  Widget _buildGetInTouch(BuildContext context, String name) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: EdgeInsets.only(top: 8.0),
      child: Text(
        "Award ${name.split(" ")[0]},",
        style: TextStyle(fontFamily: 'Roboto', fontSize: 16.0),
      ),
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: InkWell(
              onTap: () async {
                presAwardTime = DateTime.now();
                dynamic prevAwardTime = await DatabaseService(uid: widget.uidt)
                    .getRecentTime(widget.giveruid);

                if (prevAwardTime == null) {
                  setState(() {
                    _points = _points + 1;
                    _rate = _points ~/ 365;
                  });
                  await DatabaseService(uid: widget.uidt).incrementPoints();
                  await DatabaseService(uid: widget.uidt)
                      .setRecentTime(widget.giveruid, presAwardTime);
                  await DatabaseService(uid: widget.uidt)
                      .updateTimeHistory(widget.giveruid, presAwardTime);
                  await DatabaseService(uid: widget.uidt)
                      .setStats(presAwardTime.month);
                } else if (DateTime.now().difference(prevAwardTime) >
                    fixedTime) {
                  setState(() {
                    _points = _points + 1;
                    _rate = _points ~/ 365;
                  });
                  await DatabaseService(uid: widget.uidt).incrementPoints();
                  await DatabaseService(uid: widget.uidt)
                      .updateRecentTime(widget.giveruid, presAwardTime);
                  await DatabaseService(uid: widget.uidt)
                      .updateTimeHistory(widget.giveruid, presAwardTime);
                  await DatabaseService(uid: widget.uidt)
                      .setStats(presAwardTime.month);
                } else {
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content:
                        Text('You cannot award now!!Come back after a day'),
                    duration: Duration(seconds: 3),
                  ));
                  print("Cant award");
                }
              },
              child: Container(
                height: 40.0,
                decoration: BoxDecoration(
                  border: Border.all(),
                ),
                child: Center(
                  child: Text(
                    "AWARD",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 10.0),
          Expanded(
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: 40.0,
                decoration: BoxDecoration(
                  border: Border.all(),
                ),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "BACK",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    if (prevAwardTime != null &&
//        DateTime.now().difference(prevAwardTime) > fixedTime) {
//      setState(() {
//        btnColor = Colors.yellow[800];
//      });
//    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    final pData = Provider.of<PointsData>(context);
    if (pData == null)
      print("null data");
    else {
      setState(() {
        _points = pData.points;
        _rate = pData.rate.round();
      });
    }

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: widget.uidt).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return Scaffold(
              body: Stack(
                children: <Widget>[
                  //_buildCoverImage(screenSize),
                  SafeArea(
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: screenSize.height / 8.4),
                          _buildProfileImage(userData.photoUrl),
                          _buildFullName(userData.name),
                          _buildStatus(context, userData.nickname),
                          _buildStatContainer(userData.age),
                          //_buildBio(context),
                          //_buildSeparator(screenSize),
                          SizedBox(height: 10.0),
                          _buildGetInTouch(context, userData.name),
                          SizedBox(height: 8.0),
                          _buildButtons(context),
                          SizedBox(height: screenSize.height / 6.4),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }

//  @override
//  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
//    super.debugFillProperties(properties);
//    properties.add(StringProperty('_points', _points));
//  }
}
