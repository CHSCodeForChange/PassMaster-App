import 'package:chs_weather_app/pages/home.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CHS Weather',
      theme: ThemeData.dark(),
      home: HomePage(),
    );
  }
}