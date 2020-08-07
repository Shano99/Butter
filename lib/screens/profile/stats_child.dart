import 'package:charts_flutter/flutter.dart' as charts;
import 'package:butter_app/models/user.dart';
import 'package:butter_app/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StatsChild extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    List<int> monthlyPoints = [];
    List<MP> data = [];
    PointsData pData;

    List<charts.Series<MP, String>> series = [];

    return StreamBuilder<PointsData>(
        stream: DatabaseService(uid: user.uid).pointsData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            pData = snapshot.data;

            return Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: new Card(
                          elevation: 8,
                          margin: EdgeInsets.all(4),
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "POINTS",
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                pData.points.toString() ?? '0',
                                style: TextStyle(
                                  fontSize: 40,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: new Card(
                          elevation: 8,
                          margin: EdgeInsets.all(4),
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "RATE",
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                pData.rate.toString() ?? '0',
                                style: TextStyle(
                                  fontSize: 40,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  StreamBuilder<List<int>>(
                      stream: DatabaseService(uid: user.uid).statsData,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          monthlyPoints = snapshot.data;
                          for (int i = 1; i <= 12; i++) {
                            data.add(MP((i).toString(), monthlyPoints[i - 1]));
                          }
                          print("hasdata");
                          print(monthlyPoints[0]);
                          series = [
                            charts.Series(
                                id: "Points",
                                data: data,
                                domainFn: (MP mp, __) => mp.month,
                                measureFn: (MP mp, _) => mp.point,
                                colorFn: (_, __) =>
                                    charts.ColorUtil.fromDartColor(
                                        Color(0xfff9a825)))
                          ];
                          return Container(
                            child: Expanded(
                              child: charts.BarChart(series, animate: true),
                            ),
                          );
                        } else {
                          return Container();
                        }
                      }),
                ],
              ),
            );
          } else {
            return Container();
          }
        });
  }
}
