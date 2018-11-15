import 'package:flutter/material.dart';
import 'package:pass_master/pages/startup.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Startup()
    );
  }
}