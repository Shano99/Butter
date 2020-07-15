import 'package:butter_app/services/database_service.dart';
import 'package:butter_app/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:butter_app/shared/constants.dart';
import 'package:provider/provider.dart';
import 'package:butter_app/models/user.dart';

class AccountChild extends StatefulWidget {
  @override
  _AccountChildState createState() => _AccountChildState();
}

class _AccountChildState extends State<AccountChild> {
  String name = "";
  DateTime dateTime;
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF73AEF5),
                    Color(0xFF61A4F1),
                    Color(0xFF478DE0),
                    Color(0xFF398AE5),
                  ],
                  stops: [0.1, 0.4, 0.7, 0.9],
                ),
              ),
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal: 40.0,
                  vertical: 120.0,
                ),
                child: Form(
                  key: _formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Name',
                        style: kLabelStyle,
                      ),
                      SizedBox(height: 10.0),
                      Container(
                        alignment: Alignment.centerLeft,
                        decoration: kBoxDecorationStyle,
                        height: 60.0,
                        child: TextFormField(
                          initialValue: userData.name,
                          keyboardType: TextInputType.text,
                          validator: (val) => val.isEmpty ? "Enter name" : null,
                          onChanged: (val) {
                            setState(() {
                              name = val;
                            });
                          },
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'OpenSans',
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(top: 14.0),
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.white,
                            ),
                            hintText: 'Enter your Name',
                            hintStyle: kHintTextStyle,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Text(
                        'Date of Birth',
                        style: kLabelStyle,
                      ),
                      SizedBox(height: 10.0),
                      Container(
                        alignment: Alignment.centerLeft,
                        decoration: kBoxDecorationStyle,
                        height: 60.0,
                        child: Row(
                          children: <Widget>[
                            TextFormField(
                              initialValue:
                                  userData.dob ?? DateTime.now().toString(),
                              validator: (val) =>
                                  val.isEmpty ? "Enter DOB" : null,
                              obscureText: true,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'OpenSans',
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(top: 14.0),
                                prefixIcon: Icon(
                                  Icons.cake,
                                  color: Colors.white,
                                ),
                                hintText: "Birthday",
                                hintStyle: kHintTextStyle,
                              ),
                            ),
                            RaisedButton(
                              child: Text("Pick"),
                              onPressed: () {
                                showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1947),
                                        lastDate: DateTime(2015))
                                    .then((date) {
                                  setState(() {
                                    dateTime = date;
                                  });
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
