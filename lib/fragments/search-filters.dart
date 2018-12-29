import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SearchFilters extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new Row(
      children: <Widget>[
        new Expanded(
          child: new TextFormField(   
            decoration: InputDecoration(
              hintText: 'Search',
              border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
              labelStyle: TextStyle(color: Colors.black),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
        ),
        new Container(
          margin: EdgeInsets.only(left:5.0),
          height: 55.0,
          width: 55.0,            
          child: new RaisedButton(
            child: new Icon(Icons.tune),
            color: Colors.white,
            onPressed: () => {},
          )
        )  
      ],
    );
  }
}