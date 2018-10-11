import 'package:flutter/material.dart';
import 'package:pass_master/pages/main/main.dart';
import 'package:pass_master/pages/auth/login.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Login()
    );
  }
}