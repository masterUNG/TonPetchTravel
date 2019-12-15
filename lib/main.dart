import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tonpetchtravel/scaffold/catagory.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.deepOrange),
      title: "Ton Petch",
      home: Category(),
    );
  }
}
