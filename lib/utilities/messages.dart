import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class Messages {
  static void error(String message, BuildContext context) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
        content: Text(
          message,
          style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
        ),
      )
    );
  }

  static void message(String message, BuildContext context) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        duration: Duration(seconds: 2),
        backgroundColor: Colors.teal,
        content: Text(
          message,
          style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
        ),
      )
    );
  }

  static void clear(BuildContext context) {
      final scaffold = Scaffold.of(context);
      scaffold.hideCurrentSnackBar();
  }
  
}