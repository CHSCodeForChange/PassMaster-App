import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../validation/basic.dart';

class MyField extends StatelessWidget {
  String name;
  bool obscured;

  String value;

  MyField(this.name, this.obscured);

  @override
  Widget build(BuildContext covariant) {
    return new TextFormField(
      obscureText: obscured,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        fillColor: Colors.white,
        filled: true,
        hintText: name, 
      ),
      validator: (value) => Basic().validate(value, name),
      onSaved: (value) {
        this.value = value;
      },
    );
  }

}