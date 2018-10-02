import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../fragments/dropdown.dart';
import './add/teacher.dart';
import './add/srt.dart';
import './add/location.dart';
import '../../models/currentuser.dart';

class Add extends StatefulWidget {
  CurrentUserModel user;

  Add(this.user);

  @override
  AddState createState() => new AddState(user);
}

class AddState extends State<Add> {
  CurrentUserModel user;

  AddState(this.user);

  int value = 0;

  void function (int value) {
    setState(() {
      this.value = value;
    });
    print(this.value);
  }

  Widget getForm() {
    switch(value) {
      case 0:
        return TeacherPassForm();
      case 1: 
        return LocationPassForm();
      case 2: 
        return SRTPassForm();
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Container( 
      margin: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 10.0, right: 10.0),
      child: new Column(
        children: <Widget>[
          new Container(
            width: double.infinity,
            child: new Container(
              margin: EdgeInsets.only(bottom: 1.25),
              child: new Dropdown(["Teacher", "Location", "SRT"], function)
            ),
          ),
          new Container(
            child: new Container(
              margin: EdgeInsets.only(top: 1.25, bottom: 1.25),
              padding: EdgeInsets.all(10.0),
              child: new Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                child: new Container(
                  width: double.infinity,

                  padding: EdgeInsets.all(10.0),
                  child: getForm()
                )
              ),
            )
          ),
          new Container(
            margin: EdgeInsets.only(top: 1.25, bottom: 2.5),
            width: 325.0,
            child: new RaisedButton(
              onPressed: () {},
              color: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
              child: new Text('Submit'),
            ),
          )
        ],
      ),
    );
  }
}