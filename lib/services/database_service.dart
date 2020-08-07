import 'package:butter_app/models/user.dart';
import 'package:butter_app/screens/home/history_services/history_child.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class DatabaseService {
  final String uid;
  final CollectionReference personalCollection =
      Firestore.instance.collection("Personal");

  final CollectionReference locationCollection =
      Firestore.instance.collection("Location");

  final CollectionReference pointCollection =
      Firestore.instance.collection("Point");

  final CollectionReference recentTimeCollection =
      Firestore.instance.collection("TimeStamp");

  final CollectionReference historyCollection =
      Firestore.instance.collection("History");

  final CollectionReference statsCollection =
      Firestore.instance.collection("Stats");

  DatabaseService({this.uid});

  Future createUserData(
      String name,
      String age,
      String photoUrl,
      String cakeDay,
      String nickname,
      String phoneNumber,
      String country) async {
    return await personalCollection.document(uid).setData({
      'name': name,
      "nickname": nickname,
      'age': age,
      "photoUrl": photoUrl,
      "cakeDay": cakeDay,
      "phoneNumber": phoneNumber,
      "country": country,
    });
  }

  Future updateLocation(String uidt, GeoPoint point) async {
    return await locationCollection
        .document(uid)
        .setData({'uid': uidt, 'geopoint': point});
  }

  Future updatePoints(
    int total,
    int rate,
  ) async {
    return await pointCollection.document(uid).setData({
      'total': total,
      "rate": rate,
    });
  }

  Future incrementPoints() async {
    final snapshot = await pointCollection.document(uid).get();

    return await pointCollection.document(uid).setData({
      'total': FieldValue.increment(1),
      "rate": (snapshot.data['total'] + 1) / 365,
    });
  }

  Future<bool> checkUserExist() async {
    final snapshot = await personalCollection.document(uid).get();
    return (!snapshot.exists);
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: snapshot.data['uid'],
      name: snapshot.data["name"],
      nickname: snapshot.data["nickname"],
      age: snapshot.data["age"],
      photoUrl: snapshot.data["photoUrl"],
      cakeDay: snapshot.data["cakeDay"],
      phoneNumber: snapshot.data["phoneNumber"],
      country: snapshot.data["country"],
    );
  }

  Stream<UserData> get userData {
    return personalCollection
        .document(uid)
        .snapshots()
        .map(_userDataFromSnapshot);
  }

  PointsData _pointsDataFromSnapshot(DocumentSnapshot snapshot) {
    double rate1 = snapshot.data['rate'];
    return PointsData(points: snapshot.data['total'], rate: rate1.round());
  }

  Stream<PointsData> get pointsData {
    return pointCollection
        .document(uid)
        .snapshots()
        .map(_pointsDataFromSnapshot);
  }

  List<UserLocation> _locationListSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return UserLocation(uid: doc.data['uid'], gpoint: doc.data['geopoint']);
    }).toList();
  }

  Stream<List<UserLocation>> get locations {
    return locationCollection.snapshots().map(_locationListSnapshot);
  }

  Future updateRecentTime(String uidt, DateTime time) async {
    return await recentTimeCollection.document(uid).updateData({uidt: time});
  }

  Future setRecentTime(String uidt, DateTime time) async {
    return await recentTimeCollection
        .document(uid)
        .setData({uidt: time}, merge: true);
  }

  Future<DateTime> getRecentTime(String giveruid) async {
    final snapshot = await recentTimeCollection.document(uid).get();
    if (snapshot.exists) {
      if (snapshot.data[giveruid] == null) {
        return null;
      }
      DateTime dateTime = snapshot.data[giveruid].toDate();
      return dateTime;
    }
    return null;
  }

  Future updateTimeHistory(String giverUid, DateTime time) async {
    final snapshot = await historyCollection.document(uid).get();
    if (!snapshot.exists) {
      return await historyCollection.document(uid).setData({
        giverUid: FieldValue.arrayUnion([time])
      });
    }
    return await historyCollection.document(uid).updateData({
      giverUid: FieldValue.arrayUnion([time])
    });
  }

  Future setStats(int month) async {
    final snapshot = await statsCollection.document(uid).get();
    if (!snapshot.exists || snapshot.data[month.toString()] == null) {
      return await statsCollection.document(uid).setData({
        month.toString(): 1,
      }, merge: true);
    }
    return await statsCollection.document(uid).updateData({
      month.toString(): FieldValue.increment(1),
    });
  }

  List<HistoryData> _historysnap(DocumentSnapshot snapshot) {
    List<HistoryData> hdata = [];

    if (snapshot.data == null)
      return null;
    else {
      snapshot.data.forEach((key, value) async {
        hdata.add(HistoryData(uid: key, dateTime: value));
      });
      return hdata;
    }
  }

  Stream<List<HistoryData>> get historyData {
    return historyCollection.document(uid).snapshots().map(_historysnap);
  }

  List<PointsList> _pointsFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return PointsList(
          uid: doc.documentID,
          points: doc.data['total'],
          rate: doc.data['rate'].round());
    }).toList();
  }

  Stream<List<PointsList>> get pointsList {
    return pointCollection.snapshots().map(_pointsFromSnapshot);
  }

  List<int> _statsSnap(DocumentSnapshot snapshot) {
    List<int> months = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
    if (!snapshot.exists) {
      return null;
    }
    snapshot.data.forEach((key, value) async {
      months[int.parse(key) - 1] = value;
    });
    return months;
  }

  Stream<List<int>> get statsData {
    return statsCollection.document(uid).snapshots().map(_statsSnap);
  }
}
