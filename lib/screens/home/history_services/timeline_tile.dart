import 'package:butter_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:provider/provider.dart';
import 'package:jiffy/jiffy.dart';

class TimeLineTileBuilder extends StatefulWidget {
  final TimeLineData timeLineData;
  TimeLineTileBuilder({this.timeLineData});

  @override
  _TimeLineTileBuilderState createState() => _TimeLineTileBuilderState();
}

class _TimeLineTileBuilderState extends State<TimeLineTileBuilder> {
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserData>(context);
    String name;
    String nickname;
    String photoUrl;
    String date = widget.timeLineData.date.toString();
    if (userData == null) {
      return Container();
    }
    setState(() {
      name = userData.name ?? 'ButterUser';
      nickname = userData.nickname ?? 'ButterUser';
      photoUrl = userData.photoUrl ?? null;
    });

    return TimelineTile(
      alignment: TimelineAlign.center,
      indicatorStyle: IndicatorStyle(
        width: 30,
        color: Colors.white,
        indicatorY: 0.4,
        iconStyle: IconStyle(
          color: Color(0xfff9a825),
          iconData: Icons.star,
        ),
      ),
      lineX: 0.2,
      topLineStyle: const LineStyle(
        color: Colors.black,
        width: 3,
      ),
      rightChild: Container(
        padding: EdgeInsets.fromLTRB(4, 8, 4, 10),
        child: Card(
          margin: EdgeInsets.all(1),
          elevation: 8,
          child: ListTile(
            leading: CircleAvatar(
              radius: 20,
              child: Image(
                fit: BoxFit.cover,
                image: photoUrl == null || photoUrl == ''
                    ? AssetImage("assets/images/yellow.png")
                    : NetworkImage(photoUrl),
              ),
            ),
            title: Text(name),
            subtitle: Text(nickname),
          ),
        ),
      ),
      leftChild: Container(
        child: Card(
            margin: EdgeInsets.all(4),
            elevation: 8,
            child: Text(Jiffy(date).format('MMMM do yyyy'))),
      ),
    );
  }
}
