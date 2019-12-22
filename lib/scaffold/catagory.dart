import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tonpetchtravel/scaffold/language.dart';
import 'package:tonpetchtravel/scaffold/travel_listview.dart';

class Category extends StatefulWidget {
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  // Field
  List<String> imageSources = [
    'images/place.png',
    'images/play.png',
    'images/culture.png',
    'images/knowlegde.png'
  ];
  List<String> names = [
    'Place',
    'Play',
    'Culture',
    'Knowlegde',
  ];
  List<String> namesThai = [
    'สถานที่',
    'การละเล่น',
    'วัฒนธรรม',
    'ภูมิปัญญา',
  ];
  List<String> namesChina = [
    '位置',
    '玩游戏',
    '文化',
    '智慧',
  ];

  String chooseLanguage;

  // Method
  @override
  void initState() {
    super.initState();
    checkLanguage();
  }

  Future<void> checkLanguage() async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      chooseLanguage = sharedPreferences.getString('Language');
      print('chooseLanguage: $chooseLanguage');
      if (chooseLanguage == null) {
        setEnglishDefault();
      } else {
        setState(() {});
      }
    } catch (e) {}
  }

  Future<void> setEnglishDefault() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('Language', 'English');
  }

  Widget settingButton() {
    return IconButton(
      icon: Icon(Icons.settings),
      onPressed: () {
        MaterialPageRoute materialPageRoute =
            MaterialPageRoute(builder: (BuildContext buildContext) {
          return Language();
        });
        Navigator.of(context).push(materialPageRoute).then((Object) {
          checkLanguage();
        });
      },
    );
  }

  Widget mySizeBox() {
    return SizedBox(
      width: 16.0,
      height: 16.0,
    );
  }

  Widget row1() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        placeCategory(),
        mySizeBox(),
        foodCategory(),
      ],
    );
  }

  Widget row2() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        cultureCategory(),
        mySizeBox(),
        knowledgeCategory(),
      ],
    );
  }

  Widget showImage(int index) {
    return Container(
      width: 80.0,
      height: 80.0,
      child: Image.asset(imageSources[index]),
    );
  }

  Widget showText(int index) {
    String string = names[index];
    if (chooseLanguage == 'Thai') {
      string = namesThai[index];
    } else if (chooseLanguage == 'China') {
      string = namesChina[index];
    }
    return Text(string);
  }

  void routeToTravelList(int index) {
    MaterialPageRoute materialPageRoute =
        MaterialPageRoute(builder: (BuildContext buildContext) {
      return TravelListView(
        category: names[index],
      );
    });
    Navigator.of(context).push(materialPageRoute);
  }

  Widget placeCategory() {
    return Container(
      width: 120,
      height: 120,
      child: GestureDetector(
        onTap: () {
          routeToTravelList(0);
        },
        child: Card(
          child: Column(
            children: <Widget>[showImage(0), showText(0)],
          ),
        ),
      ),
    );
  }

  Widget foodCategory() {
    return Container(
      width: 120,
      height: 120,
      child: GestureDetector(
        onTap: () {
          routeToTravelList(1);
        },
        child: Card(
          child: Column(
            children: <Widget>[showImage(1), showText(1)],
          ),
        ),
      ),
    );
  }

  Widget cultureCategory() {
    return Container(
      width: 120,
      height: 120,
      child: GestureDetector(
        onTap: () {
          routeToTravelList(2);
        },
        child: Card(
          child: Column(
            children: <Widget>[showImage(2), showText(2)],
          ),
        ),
      ),
    );
  }

  Widget knowledgeCategory() {
    return Container(
      width: 120,
      height: 120,
      child: GestureDetector(
        onTap: () {
          routeToTravelList(3);
        },
        child: Card(
          child: Column(
            children: <Widget>[showImage(3), showText(3)],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[settingButton()],
        title: Text('Category'),
      ),
      body: Container(
        margin: EdgeInsets.only(
          top: 100.0,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            row1(),
            mySizeBox(),
            row2(),
          ],
        ),
      ),
    );
  }
}
