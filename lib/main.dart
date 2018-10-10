import 'package:flutter/material.dart';
import './pages/main/main.dart';
import './pages/auth/login.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Login()
    );
  }
}