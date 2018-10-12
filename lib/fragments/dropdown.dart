import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Dropdown extends StatefulWidget {
  List<String> strings;
  List<String> values;
  var function;
  DropdownState state;

  int getIndex() {
    return state.value;
  }

  String getValue() {
    return values != null ? values[getIndex()] : getIndex().toString();
  }

  Dropdown(List<String> strings, {List<String> values, var function}) {
    this.strings = strings;
    this.values = values;
    this.function = function;
  }

  @override
  DropdownState createState() => new DropdownState(this, strings, function);
}

class DropdownState extends State<Dropdown> {
  int value = 0;
  var function;
  List<DropdownMenuItem> types = [];

  DropdownState (Dropdown parent, List<String> strings, var function) {
    parent.state = this;
    this.function = function;

    for (int i = 0; i < strings.length; i++) {
      types.add(
        new DropdownMenuItem(
          child: new Text(
            strings[i],
            textAlign: TextAlign.center,
          ),
          value: i,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return new DropdownButton(
      items: this.types,
      value: this.value,
      style: TextStyle(fontSize: 17.0, color: Colors.grey),
      onChanged: (value) {
        setState(() {
          this.value = value; 
        });
        if (function != null) {
          function(value);
        }
      },
    );
  }  
}