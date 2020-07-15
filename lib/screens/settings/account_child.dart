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
  String name;
  String photoUrl;
  String nickname;
  String age;
  String country;
  String cakeDay;

  String phoneNumber;
  final _formKey = GlobalKey<FormState>();

  String error = "";
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
                  vertical: 40.0,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: userData.photoUrl == ""
                            ? null
                            : NetworkImage(userData.photoUrl),
                        radius: 80.0,
                      ),
                      SizedBox(height: 20.0),
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
                        'NickName',
                        style: kLabelStyle,
                      ),
                      SizedBox(height: 10.0),
                      Container(
                        alignment: Alignment.centerLeft,
                        decoration: kBoxDecorationStyle,
                        height: 60.0,
                        child: TextFormField(
                          initialValue: userData.nickname,
                          keyboardType: TextInputType.text,
                          validator: (val) =>
                              val.isEmpty ? "Enter nickname" : null,
                          onChanged: (val) {
                            setState(() {
                              nickname = val;
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
                            hintText: 'Enter your nickname',
                            hintStyle: kHintTextStyle,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Text(
                        'Age',
                        style: kLabelStyle,
                      ),
                      SizedBox(height: 10.0),
                      Container(
                        alignment: Alignment.centerLeft,
                        decoration: kBoxDecorationStyle,
                        height: 60.0,
                        child: TextFormField(
                          initialValue: userData.age,
                          validator: (val) => val.isEmpty ? "Enter age" : null,
                          onChanged: (val) {
                            setState(() {
                              age = val;
                            });
                          },
                          keyboardType: TextInputType.number,
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
                            hintText: 'Enter your age',
                            hintStyle: kHintTextStyle,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Text(
                        'Phone Number',
                        style: kLabelStyle,
                      ),
                      SizedBox(height: 10.0),
                      Container(
                        alignment: Alignment.centerLeft,
                        decoration: kBoxDecorationStyle,
                        height: 60.0,
                        child: TextFormField(
                          initialValue: userData.phoneNumber,
                          validator: (val) => val.length != 10
                              ? "Enter valid phone number"
                              : null,
                          onChanged: (val) {
                            setState(() {
                              phoneNumber = val;
                            });
                          },
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'OpenSans',
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(top: 14.0),
                            prefixIcon: Icon(
                              Icons.phone,
                              color: Colors.white,
                            ),
                            hintText: 'Enter phone number',
                            hintStyle: kHintTextStyle,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Text(
                        'Country',
                        style: kLabelStyle,
                      ),
                      SizedBox(height: 10.0),
                      Container(
                        alignment: Alignment.centerLeft,
                        decoration: kBoxDecorationStyle,
                        height: 60.0,
                        child: TextFormField(
                          initialValue: userData.country,
                          validator: (val) =>
                              val.isEmpty ? "enter country" : null,
                          onChanged: (val) {
                            country = val;
                          },
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'OpenSans',
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(top: 14.0),
                            prefixIcon: Icon(
                              Icons.map,
                              color: Colors.white,
                            ),
                            hintText: 'Enter your country',
                            hintStyle: kHintTextStyle,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 25.0),
                        width: double.infinity,
                        child: RaisedButton(
                          elevation: 5.0,
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              dynamic res = await DatabaseService(uid: user.uid)
                                  .createUserData(
                                      name ?? userData.name,
                                      age ?? userData.age,
                                      photoUrl ?? userData.photoUrl,
                                      cakeDay ?? userData.cakeDay,
                                      nickname ?? userData.nickname,
                                      phoneNumber ?? userData.phoneNumber,
                                      country ?? userData.country);
                              if (res != null) {
                                setState(() {
                                  error = "could not update";
                                });
                              } else {
                                setState(() {
                                  error = "Updated successfully";
                                });

                                print(userData.phoneNumber);
                              }
                            }
                          },
                          padding: EdgeInsets.all(15.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          color: Colors.white,
                          child: Text(
                            'UPDATE',
                            style: TextStyle(
                              color: Color(0xFF527DAA),
                              letterSpacing: 1.5,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'OpenSans',
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                        child: Text(
                          error,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'OpenSans',
                            fontSize: 10.0,
                            fontWeight: FontWeight.bold,
                          ),
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
