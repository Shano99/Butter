import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String uid;
  User({this.uid});
}

class UserData {
  final String uid;
  final String name;
  final String age;
  final String photoUrl;
  final String cakeDay;
  final String nickname;
  final String phoneNumber;
  final String country;

  UserData(
      {this.uid,
      this.name,
      this.nickname,
      this.age,
      this.photoUrl,
      this.cakeDay,
      this.phoneNumber,
      this.country});
}

class UserLocation {
  final String uid;
  final GeoPoint gpoint;
  UserLocation({this.uid, this.gpoint});
}

class PointsData {
  final int points;
  final int rate;
  PointsData({this.points, this.rate});
}

class HistoryData {
  final String uid;

  final List<dynamic> dateTime;
  HistoryData({this.uid, this.dateTime});
}

class TimeLineData {
  final String uid;
  final DateTime date;

  TimeLineData({this.uid, this.date});
}

class PointsList {
  String uid;
  final int points;
  final int rate;
  PointsList({this.uid, this.points, this.rate});
}

class MP {
  final String month;
  final int point;
  MP(this.month, this.point);
}
