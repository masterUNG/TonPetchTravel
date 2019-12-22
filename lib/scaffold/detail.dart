import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tonpetchtravel/utility/my_style.dart';

import '../models/travel_model.dart';

class Detail extends StatefulWidget {
  final TravalModel travalModel;
  Detail({Key key, this.travalModel}) : super(key: key);
  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  // Field
  TravalModel myTravalModel;
  List<String> urlPaths = List();

  // Method
  @override
  void initState() {
    super.initState();
    myTravalModel = widget.travalModel;

    print('lat ====> ${myTravalModel.lat}');

    createArrayList();
  }

  Widget showMap() {
    double lat = myTravalModel.lat;
    double lng = myTravalModel.lng;

    LatLng latLng = LatLng(lat, lng);
    CameraPosition cameraPosition = CameraPosition(
      target: latLng,
      zoom: 16.0,
    );

    return Container(
      color: Colors.grey,
      width: 300.0,
      height: 200.0,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: cameraPosition,
        onMapCreated: (GoogleMapController googleMapController) {},
      ),
    );
  }

  Widget showMapLatLng() {
    if (myTravalModel.lat == null) {
      return SizedBox();
    } else {
      return showMap();
    }
  }

  Widget showTextDetail() {
    return Container(
      padding: EdgeInsets.only(left: 16.0, right: 16.0),
      child: Text(myTravalModel.detail.replaceAll('*', '\n')),
    );
  }

  void createArrayList() {
    String path = myTravalModel.path;
    if (path.length != 0) {
      setState(() {
        urlPaths.add(path);
      });
    }

    String path2 = myTravalModel.path2;
    if (path2.length != 0) {
      setState(() {
        urlPaths.add(path2);
      });
    }

    String path3 = myTravalModel.path3;
    if (path3.length != 0) {
      setState(() {
        urlPaths.add(path3);
      });
    }

    String path4 = myTravalModel.path4;
    if (path4.length != 0) {
      setState(() {
        urlPaths.add(path4);
      });
    }

    String path5 = myTravalModel.path5;
    if (path5.length != 0) {
      setState(() {
        urlPaths.add(path5);
      });
    }

    String path6 = myTravalModel.path6;
    if (path6.length != 0) {
      setState(() {
        urlPaths.add(path6);
      });

      print('urlPaths ==> $urlPaths');
    }
  }

  Widget showImage() {
    return Expanded(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: urlPaths.length,
        itemBuilder: (BuildContext buildContext, int index) {
          return Container(
            width: 300.0,
            height: 200.0,
            child: Image.network(
              urlPaths[index],
              fit: BoxFit.contain,
            ),
          );
        },
      ),
    );
  }

  Widget header() {
    return Text(
      myTravalModel.name,
      style: MyStyle().h2Text,
    );
  }

  Widget showListDetail() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        header(),
        showImage(),
        Expanded(
          child: ListView(
            children: <Widget>[
              showTextDetail(),
              showMapLatLng(),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail'),
      ),
      body: showListDetail(),
    );
  }
}
