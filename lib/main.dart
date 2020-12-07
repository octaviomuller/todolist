import 'package:flutter/material.dart';
import 'package:todo/screen/Home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Colors.indigo[800],
          accentColor: Colors.cyan,
          fontFamily: 'Roboto'),
      home: Home('To Do List'),
    );
  }
}
