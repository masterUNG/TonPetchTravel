import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tonpetchtravel/models/travel_model.dart';
import 'package:tonpetchtravel/scaffold/detail.dart';

class TravelListView extends StatefulWidget {
  final String category;
  TravelListView({Key key, this.category}) : super(key: key);

  @override
  _TravelListViewState createState() => _TravelListViewState();
}

class _TravelListViewState extends State<TravelListView> {
// field
  String currentCategory, currentLanguage;
  List<TravalModel> travalModels = List();

// method
  @override
  void initState() {
    super.initState();
    currentCategory = widget.category;
    getLanguage();
  }

  Future<void> getLanguage() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    currentLanguage = sharedPreferences.getString('Language');
    readFireStore();
  }

  Future<void> readFireStore() async {
    print('Language: $currentLanguage');
    print('Category: $currentCategory');
    Firestore firestore = Firestore.instance;
    CollectionReference collectionReference = firestore.collection('Travel');
    await collectionReference
        .document(currentLanguage)
        .collection('Category')
        .document(currentCategory)
        .collection('MenuItem')
        .snapshots()
        .listen((QuerySnapshot querySnapshot) {
      List<DocumentSnapshot> snapshots = querySnapshot.documents;
      for (var map in snapshots) {
        // print('map: ${map.data}');
        TravalModel travalModel = TravalModel.fromJson(map.data);
        setState(() {
          travalModels.add(travalModel);
        });
      }
    });
  }

  Widget showImage(int index) {
    return Container(
      padding: EdgeInsets.all(10.0),
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.width * 0.4,
      child: Image.network(travalModels[index].path),
    );
  }

  Widget showName(int index) {
    return Text(
      travalModels[index].name,
      style: TextStyle(fontWeight: FontWeight.bold),
    );
  }

  Widget showDetail(int index) {
    String string = travalModels[index].detail;
    if (string.length >= 40) {
      string = string.substring(0, 39).replaceAll('*', '\n');
      string = '$string ...';
    }
    return Text(string);
  }

  Widget showText(int index) {
    return Container(
      padding: EdgeInsets.all(10.0),
      width: MediaQuery.of(context).size.width * 0.5,
      // height: MediaQuery.of(context).size.width * 0.4,
      child: Column(
        children: <Widget>[
          showName(index),
          showDetail(index),
        ],
      ),
    );
  }

  Widget showListTravel() {
    return ListView.builder(
      itemCount: travalModels.length,
      itemBuilder: (BuildContext buildContext, int index) {
        return GestureDetector(
          onTap: () {
            MaterialPageRoute materialPageRoute =
                MaterialPageRoute(builder: (BuildContext buildContext) {
              return Detail(travalModel: travalModels[index],);
            });
            Navigator.of(context).push(materialPageRoute);
          },
          child: Row(
            children: <Widget>[
              showImage(index),
              showText(index),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Travel List'),
      ),
      body: showListTravel(),
    );
  }
}
