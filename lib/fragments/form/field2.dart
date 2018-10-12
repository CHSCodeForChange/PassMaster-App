import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class MyField2 extends StatelessWidget {
  String name;
  String value;
  int lines;

  MyField2 (String name, [int lines = 1]) {
    this.name = name;
    this.lines = lines;
  }

  @override 
  Widget build(BuildContext context) {
    return new TextField(
      maxLines: lines,
      onChanged: (value) {
        value = value;
      },
      decoration: new InputDecoration(
        hintText: name,
      ),
    );
  }

  bool isEmpty() {
    return value == null || value == ""; 
  }

  String getValue() {
    return value;
  }
}

