import 'package:butter_app/models/user.dart';
import 'package:butter_app/screens/home/map_service/user_info.dart';
import 'package:butter_app/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:latlong/latlong.dart';
import 'package:butter_app/services/database_service.dart';

class AwardChild extends StatefulWidget {
  @override
  _AwardChildState createState() => _AwardChildState();
}

class _AwardChildState extends State<AwardChild> {
  String receiverUid;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    final locationinfo = Provider.of<List<UserLocation>>(context) ?? [];

    if (locationinfo != null) {
      locationinfo.forEach((point) {
        if (user.uid != point.uid) {
          receiverUid = point.uid;
          //TODO: set nearest person
        }
      });
    }

    return StreamProvider<PointsData>.value(
        value: DatabaseService(uid: receiverUid).pointsData,
        child: UserInfo(uidt: receiverUid, giveruid: user.uid));
  }
}
