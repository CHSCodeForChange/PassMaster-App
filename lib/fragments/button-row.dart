import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ButtonRow extends StatefulWidget {
  List<String> strings = [];

  ButtonRow(this.strings);

  @override
  ButtonRowState createState() => new ButtonRowState(this.strings);
}

class ButtonRowState extends State<ButtonRow> {
  int value = 0;
  List<Expanded> buttons = [];

  ButtonRowState (List<String> strings) {
    for (int i = 0; i < strings.length; i++) {
      buttons.add(
        new Expanded(
          child: new Container(
            padding: EdgeInsets.all(5.0),
            child: new RaisedButton(
              onPressed: () {
                setState(() {
                  this.value = i;          
                });
                print(this.value);
              },
              color: this.value == i ? Colors.white : Colors.grey,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
              child: new Text(
                strings[i],
                textAlign: TextAlign.center,
              ),
            ),
          )
        )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Row (
      children: buttons,
    );
  }
}