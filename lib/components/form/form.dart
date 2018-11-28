import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import './field.dart';

class MyForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  List<MyField> fields;

  MyForm(this.fields);
 
  @override
  Widget build(BuildContext context) {
    return new Form(
      key: _formKey,
      child: ListView.builder(
        itemExtent: 100.0,
        itemCount: fields.length,
        padding: EdgeInsets.all(10.0),
        itemBuilder: (BuildContext context, int index) {
          return fields.elementAt(index);
        },
      )
    );
  }

  List<String> save() {
    if (_formKey.currentState.validate()) {
      List<String> values = new List<String>();
      for (MyField field in fields) {
        values.add(field.value);
      }
      return values;
    }
    return null;
  }
}