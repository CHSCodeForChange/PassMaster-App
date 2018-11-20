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

  int value = 0;

  void function (int value) {
    setState(() {
      this.value = value;
    });
  }

  TeacherPassForm teacherPassForm;
  LocationPassForm locationPassForm;
  SRTPassForm srtPassForm;

  AddState(this.user);

  Widget getForm() {
    switch(value) {
      case 0:
        return TeacherPassForm(user);
      case 1: 
        return LocationPassForm(user);
      case 2: 
        return SRTPassForm(user);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Container( 
      margin: EdgeInsets.only(top: 15.0, bottom: 10.0, left: 10.0, right: 10.0),
      child: new Column(
        children: <Widget>[
          new Container(
            width: double.infinity,
            child: new Theme(
              data: Theme.of(context).copyWith(
                canvasColor: Colors.white,
              ),
              child: new Card(
                margin: EdgeInsets.only(top: 16.0, bottom: 1.25),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                child: new Container(
                  padding: EdgeInsets.all(16.0),
                  child: new Dropdown(
                    ["Teacher", "Location", "SRT"],
                    function: function,
                  )
                ),
              ),
            ),
          ),
          new Expanded(
            child: new Container(
              margin: EdgeInsets.only(top: 1.25, bottom: 1.25),
              padding: EdgeInsets.all(0.0),
              child: getForm()
            )
          ),
        ],
      ),
    );
  }
}