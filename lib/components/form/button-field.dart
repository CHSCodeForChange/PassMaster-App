import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ButtonField extends StatefulWidget {
  String text;
  Function function;
  ButtonFieldState state;

  ButtonField(this.text, this.function);


  @override
  ButtonFieldState createState() => new ButtonFieldState(text, function, this);
  
}

class ButtonFieldState extends State<ButtonField> {
  String text;
  Function function;

  ButtonFieldState(String text, Function function, ButtonField parent) {
    this.text = text;
    this.function = function;
    parent.state = this;
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

        onPressed: function,
        child: new Container(
          width: 2000.0,
          child: new Text(
            text,
            style: TextStyle(fontSize: 15.0, color: Colors.grey),
          )
        )        
      ),
    );
  }

}