import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  String text;
  Function action;

  ActionButton(this.text, this.action);

  Widget build (BuildContext context) {
    return new RaisedButton(
      color: Colors.blueAccent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      onPressed: () {
        action();
      },
      child: new Container(
        width: 500.0,
        child: new Text(
          text,
          style: new TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      )
    );
  }
}