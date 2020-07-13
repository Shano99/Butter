import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  final CollectionReference butterCollection =
      Firestore.instance.collection("butter");

  DatabaseService({this.uid});

  Future createUserData(String name, String dob, int totalpoints) async {
    return await butterCollection
        .document(uid)
        .setData({'name': name, 'dob': dob, 'points': totalpoints});
  }

  Future<bool> checkUserExist() async {
    final snapshot = await butterCollection.document(uid).get();
    return (!snapshot.exists);
  }
}
