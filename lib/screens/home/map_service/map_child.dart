import 'package:butter_app/models/user.dart';
import 'package:butter_app/screens/home/map_service/user_info.dart';
import 'package:butter_app/services/database_service.dart';

import 'package:butter_app/shared/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:location/location.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:provider/provider.dart';

class MapChild extends StatefulWidget {
  @override
  _MapChildState createState() => _MapChildState();
}

class _MapChildState extends State<MapChild> {
  //final GlobalKey<_MapPageState> _mapPageStateKey = GlobalKey<_MapPageState>();

  List<LatLng> _points = [];
  List<String> _uids = [];
  LatLng gp;
  int ind;
  LatLng userPoint;

  final Distance distance = Distance();
  double totalDistanceInM = 0;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    _MapPageState().setuid(user);

    final locationinfo = Provider.of<List<UserLocation>>(context) ?? [];
    setState(() {
      _points = [];
      _uids = [];
      if (locationinfo != null) {
        locationinfo.forEach((point) {
          if (user.uid == point.uid && point.gpoint != null) {
            ind = locationinfo.indexOf(point);
            gp = LatLng(point.gpoint.latitude, point.gpoint.longitude);
          }

          if (point.gpoint != null) {
            _points.add(LatLng(point.gpoint.latitude, point.gpoint.longitude));
            _uids.add(point.uid);
          }
        });
      }
      if (userPoint != null) {
        for (var i = 0; i < _points.length - 1; i++) {
          totalDistanceInM += distance(_points[i], userPoint);
          if (totalDistanceInM > 50) {
            _points.removeAt(i);
          }
        }
      }
      _MapPageState()._setCurrentPoint(_points, _uids, ind);
    });

    return MaterialApp(
        home: MapPage(
            //_mapPageStateKey
            gp: gp),
        builder: (context, navigator) {
          return Scaffold(
            body: navigator,
          );
        });
  }
}

class MapPage extends StatefulWidget {
  final LatLng gp;

  MapPage(
      // GlobalKey<_MapPageState> key
      {this.gp,
      Key key})
      : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  MapController mapController = MapController();
//  Position _currentPosition;
//  GeoPoint _geoPoint;

  static User user;
  LatLng gp;
  Location location = Location();

  LocationData currentLocation;
  void setuid(User usert) {
    //print(usert.uid);
    user = usert;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    location.onLocationChanged().listen((LocationData value) {
      //  setState(() {
      currentLocation = value;
      print(currentLocation);
      gp = LatLng(currentLocation.latitude, currentLocation.longitude);
//        await DatabaseService(uid: uid).updateLocation(
//            uid, GeoPoint(currentLocation.latitude, currentLocation.longitude));
      if (currentLocation != null) updateDatabase(currentLocation);
    });
    // });
  }

  void updateDatabase(LocationData cl) async {
    await DatabaseService(uid: user.uid)
        .updateLocation(user.uid, GeoPoint(cl.latitude, cl.longitude));
  }

  @override
  void didUpdateWidget(MapPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.gp != oldWidget.gp) {
      mapController.move(gp, 0);
    }
  }

  static List<LatLng> _points = [];
  static List<String> _uids = [];
  static int ind;

  void _setCurrentPoint(List<LatLng> points, List<String> uids, int index) {
    _points = points;
    _uids = uids;
    ind = index;
  }

  static const _markerSize = 30.0;

  // Used to trigger showing/hiding of popups.
  final PopupController _popupLayerController = PopupController();

  @override
  Widget build(BuildContext context) {
    void showUserInfo(int index) {
      showModalBottomSheet<dynamic>(
          isScrollControlled: true,
          context: context,
          builder: (context) {
            return StreamProvider<PointsData>.value(
                value: DatabaseService(uid: _uids[index]).pointsData,
                child: UserInfo(uidt: _uids[index], giveruid: user.uid));
            //padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
          });
    }

    List<Marker> _markers = _points
        .map(
          (LatLng point) => Marker(
            point: point,
            width: _markerSize,
            height: _markerSize,
            builder: (_) => IconButton(
              iconSize: _markerSize,
              icon: _points.indexOf(point) == ind
                  ? Icon(
                      Icons.location_off,
                      color: Colors.green,
                    )
                  : Icon(Icons.location_on, color: Colors.black),
              onPressed: () {
                if (_points.indexOf(point) != ind)
                  showUserInfo(_points.indexOf(point));
                else {
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text('Your Position'),
                    duration: Duration(seconds: 3),
                  ));
                }
              },
            ),
            anchorPos: AnchorPos.align(AnchorAlign.top),
          ),
        )
        .toList();
    List<CircleMarker> _circleMarker = [
      CircleMarker(
        point: gp,
        radius: 300,
        color: Colors.yellow.withOpacity(0.3),
      )
    ];
    return _points.isEmpty
        ? Loading()
        : FlutterMap(
            mapController: mapController,
            options: new MapOptions(
              zoom: 23.0,
              maxZoom: 23.0,
              minZoom: 23.0,

              center: gp,
              plugins: [PopupMarkerPlugin()],
              onTap: (_) => _popupLayerController
                  .hidePopup(), // Hide popup when the map is tapped.
            ),
            layers: [
              CircleLayerOptions(
                circles: _circleMarker,
              ),
//

//              TileLayerOptions(
//                urlTemplate:
//                    'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
//                subdomains: ['a', 'b', 'c'],
//              ),
              PopupMarkerLayerOptions(
                markers: _markers,
                popupSnap: PopupSnap.top,
                popupController: _popupLayerController,
                popupBuilder: (BuildContext _, Marker marker) => Container(
                  child: Text("name"),
                ),
              ),
            ],
          );
  }
}
