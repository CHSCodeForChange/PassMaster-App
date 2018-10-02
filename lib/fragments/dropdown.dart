import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Dropdown extends StatefulWidget {
  List<String> strings = [];
  var function;

  Dropdown(this.strings, this.function);

  @override
  DropdownState createState() => new DropdownState(this.strings, this.function);
}

class DropdownState extends State<Dropdown> {
  int value = 0;
  var function;
  List<DropdownMenuItem> types = [];

  DropdownState (List<String> strings, var function) {
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
    return new Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: new Container(
        color: Colors.white,
        padding: EdgeInsets.all(10.0),
        child: new DropdownButton(
          items: this.types,
          value: this.value,
          onChanged: (value) {
            setState(() {
              this.value = value; 
            });
            function(value);
          },
        )
      )
    );
  }  
}