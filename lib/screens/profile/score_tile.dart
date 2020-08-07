import 'package:butter_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScoreTileBuilder extends StatefulWidget {
  final int point;
  final int rate;
  final int index;

  ScoreTileBuilder({this.index, this.point, this.rate});
  @override
  _ScoreTileBuilderState createState() => _ScoreTileBuilderState();
}

class _ScoreTileBuilderState extends State<ScoreTileBuilder> {
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserData>(context);
    String name;
    String nickname;
    String photoUrl;
    if (userData == null) {
      return Container();
    } else {
      setState(() {
        name = userData.name ?? 'ButterUser';
        nickname = userData.nickname ?? 'ButterUser';
        photoUrl = userData.photoUrl ?? null;
      });

      return Container(
        padding: EdgeInsets.fromLTRB(15, 10, 0, 0),
        child: Row(
          children: <Widget>[
            Text(
              "${widget.index}",
              style: TextStyle(
                fontSize: 40,
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            SizedBox(
              width: 200,
              child: Card(
                margin: EdgeInsets.all(4),
                elevation: 8,
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 20,
                    child: Image(
                      image: photoUrl.isEmpty
                          ? AssetImage("assets/images/yellow.png")
                          : NetworkImage(photoUrl),
                    ),
                  ),
                  title: Text(name),
                  subtitle: Text(nickname),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}
