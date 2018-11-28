import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import '../../models/datetime.dart';

class MyTimePicker extends StatefulWidget {
  MyTimePickerState state;
  String name;

  TimeOfDay getValue() {
    return state.value;
  }

  bool isEmpty() {
    return state.value == null;
  }

  MyTimePicker(this.name);

  @override
  MyTimePickerState createState() => new MyTimePickerState(this, name);

}

class MyTimePickerState extends State<MyTimePicker> {
  String name;
  TimeOfDay value;

  MyTimePickerState(MyTimePicker parent, String name) {
    parent.state = this;
    this.name = name;
  }

  void showPicker() async {
    value = await showTimePicker(initialTime: TimeOfDay.now(), context: context);
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
            value == null ? name : name + ": " + MyDateTime.getTime(value),
            style: TextStyle(fontSize: 15.0, color: Colors.grey),
          )
        )        
      ),
    );
  }

}