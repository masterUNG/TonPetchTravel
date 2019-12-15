import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Language extends StatefulWidget {
  @override
  _LanguageState createState() => _LanguageState();
}

class _LanguageState extends State<Language> {
// Field
  String groupString;
  String choosedLanguage = '';

// method

  @override
  void initState() {
    super.initState();
    setupRadio();
  }

  Future<void> setupRadio() async {
    print('Setup  work');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String string = sharedPreferences.getString('Language');
    if (string != null) {
      setState(() {
        groupString = string;
      });
    } else {
      setState(() {
        groupString = 'English';
      });
    }
  }

  void radioController(String string) {
    setState(() {
      groupString = string;
      choosedLanguage = string;
      print('chooseLang: $choosedLanguage');
    });
  }

  Widget englishRadio() {
    return Row(
      children: <Widget>[
        Radio(
          value: 'English',
          groupValue: groupString,
          onChanged: (String string) {
            radioController(string);
          },
        ),
        Text('English'),
      ],
    );
  }

  Widget thaiRadio() {
    return Row(
      children: <Widget>[
        Radio(
          value: 'Thai',
          groupValue: groupString,
          onChanged: (String string) {
            radioController(string);
          },
        ),
        Text('Thai'),
      ],
    );
  }

  Widget chinaRadio() {
    return Row(
      children: <Widget>[
        Radio(
          value: 'China',
          groupValue: groupString,
          onChanged: (String string) {
            radioController(string);
          },
        ),
        Text('China'),
      ],
    );
  }

  Future<void> saveLanguage()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('Language',choosedLanguage);
    Navigator.of(context).pop();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Setting'),
      ),
      body: Container(
        margin: EdgeInsets.only(
          top: 100.0,
          left: 80.0,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            englishRadio(),
            thaiRadio(),
            chinaRadio(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        onPressed: () {
          saveLanguage();
        },
      ),
    );
  }
}
