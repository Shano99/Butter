import 'package:butter_app/models/user.dart';
import 'package:butter_app/screens/home/history_services/timeline_tile.dart';
import 'package:butter_app/services/database_service.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoryChild extends StatefulWidget {
  @override
  _HistoryChildState createState() => _HistoryChildState();
}

class _HistoryChildState extends State<HistoryChild> {
  @override
  Widget build(BuildContext context) {
    List<TimeLineData> tdata = [];
    String key;

    final historyData = Provider.of<List<HistoryData>>(context) ?? [];
    if (historyData != null) {
      historyData.forEach((val) {
        key = val.uid;
        for (var i = 0; i < val.dateTime.length; i++) {
          tdata.add((TimeLineData(uid: key, date: val.dateTime[i].toDate())));
        }
      });

      //TODO:format datetime
      tdata.sort((a, b) {
        //sort
        var adate = a.date; //before -> var adate = a.expiry;
        var bdate = b.date; //before -> var bdate = b.expiry;
        return bdate.compareTo(
            adate); //to get the order other way just switch `adate & bdate`
      });
    } else {
      return Container();
    }
    return ListView.builder(
        itemCount: tdata.length,
        itemBuilder: (context, index) {
          return StreamProvider<UserData>.value(
              value: DatabaseService(uid: tdata[index].uid).userData,
              child: TimeLineTileBuilder(timeLineData: tdata[index]));
        });
  }
}
