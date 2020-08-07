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
  final Distance distance = Distance();
  double totalDistanceInM = 0;
  double min = 1.0 / 0.0;
  LatLng userLocationPoint;
  LatLng minDisPoint;
  List<LatLng> remainingPoints = [];
  List<String> uids = [];
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    final locationinfo = Provider.of<List<UserLocation>>(context) ?? [];
    setState(() {
      if (locationinfo != null) {
        locationinfo.forEach((point) {
          if (user.uid == point.uid && point.gpoint != null) {
            userLocationPoint =
                LatLng(point.gpoint.latitude, point.gpoint.longitude);
          } else {
            if (point.gpoint != null) {
              remainingPoints
                  .add(LatLng(point.gpoint.latitude, point.gpoint.longitude));
              uids.add(point.uid);
            }
          }
        });
      }
      if (userLocationPoint != null) {
        for (var i = 0; i < remainingPoints.length - 1; i++) {
          totalDistanceInM += distance(remainingPoints[i], userLocationPoint);
          if (totalDistanceInM < 50 && totalDistanceInM < min) {
            min = totalDistanceInM;
            minDisPoint = remainingPoints[i];
            receiverUid = uids[i];
          }
        }
      }
    });

    return StreamProvider<PointsData>.value(
        value: DatabaseService(uid: receiverUid).pointsData,
        child: receiverUid == null
            ? Loading()
            : UserInfo(uidt: receiverUid, giveruid: user.uid));
  }
}
