import 'package:butter_app/screens/profile/score_tile.dart';
import 'package:butter_app/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:butter_app/models/user.dart';

class ScoreChild extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pointsDataList = Provider.of<List<PointsList>>(context) ?? [];

    if (pointsDataList != null) {
      pointsDataList.sort((a, b) {
        //sort
        var adate = a.points; //before -> var adate = a.expiry;
        var bdate = b.points; //before -> var bdate = b.expiry;
        return bdate.compareTo(
            adate); //to get the order other way just switch `adate & bdate`
      });
      pointsDataList.forEach((element) {
        print(element.points);
      });
    } else {
      return Container(
        child: Text("No Data"),
      );
    }
//TODO:show current position and first three separately
    return ListView.builder(
        shrinkWrap: true,
        itemCount: pointsDataList.length,
        itemBuilder: (context, index) {
          return StreamProvider<UserData>.value(
              value: DatabaseService(uid: pointsDataList[index].uid).userData,
              child: ScoreTileBuilder(
                index: index + 1,
                point: pointsDataList[index].points,
                rate: pointsDataList[index].rate,
              ));
        });
  }
}
