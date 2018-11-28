import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import '../../models/datetime.dart';

class MyDatePicker extends StatefulWidget {
  MyDatePickerState state;
  String name;

  DateTime getValue() {
    return state.value;
  }

  bool isEmpty() {
    return state.value == null;
  }

  MyDatePicker(this.name);

  @override
  MyDatePickerState createState() => new MyDatePickerState(this, name);

}

class MyDatePickerState extends State<MyDatePicker> {
  String name;
  DateTime value;

  MyDatePickerState(MyDatePicker parent, String name) {
    parent.state = this;
    this.name = name;
  }

  void showPicker() async {
    value = await showDatePicker(firstDate: DateTime.now(), initialDate: DateTime.now(), lastDate: DateTime(2099), initialDatePickerMode: DatePickerMode.day, context: context);
    setState(() {
      value = value;
    });
  }

  @override
  Widget build(BuildContext context) {

    return new Container(
      alignment: Alignment.topLeft,
      child: new RaisedButton(
        padding: EdgeInsets.all(0.0),
        color: Colors.white,
        elevation: 0.0,
        shape: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 0.5, style: BorderStyle.solid)),

        onPressed: showPicker,
        child: new Container(
          width: 2000.0,
          child: new Text(
            value == null ? name : name + ": " + MyDateTime.getDate(value),
            style: TextStyle(fontSize: 15.0, color: Colors.grey),
          )
        )        
      ),
    );
  }

}