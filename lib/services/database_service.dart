import 'package:butter_app/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  final CollectionReference personalCollection =
      Firestore.instance.collection("Personal");

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
      "country": country
    });
  }

  Future<bool> checkUserExist() async {
    final snapshot = await personalCollection.document(uid).get();
    return (!snapshot.exists);
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: snapshot.data['uid'],
      dob: snapshot.data['dob'],
      name: snapshot.data['name'],
    );
  }

  Stream<UserData> get userData {
    return personalCollection
        .document(uid)
        .snapshots()
        .map(_userDataFromSnapshot);
  }
}
