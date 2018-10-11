import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

import '../../../models/user.dart';
import '../../../models/srt-pass.dart';
import '../../../models/pass.dart';
import '../../../models/currentuser.dart';
import '../../../fragments/user-search.dart';
import '../../../fragments/dropdown.dart';
import '../../../fragments/form/button-field.dart';
import './parent.dart';
import '../../../fragments/messages.dart';

class TeacherPassForm extends StatefulWidget {
  CurrentUserModel user;

  TeacherPassForm(this.user);

  @override
  TeacherPassFormState createState() => new TeacherPassFormState(user);
}

class TeacherPassFormState extends State<TeacherPassForm> {
  final dateFormat = DateFormat("EEEE, MMMM d, yyyy");
  final timeFormat = DateFormat.jm();
  CurrentUserModel user;

  UserModel originTeacher;
  UserModel destinationTeacher;
  UserModel student;

  DateTime date;
  String session;
  String description;

  ButtonField originTeacherField;
  ButtonField destinationTeacherField;
  ButtonField studentField; 

  Function function;

  TeacherPassFormState(CurrentUserModel user) {
    this.user = user;

    function = ((int value) {
      session = (value+1).toString();
    });
    
    originTeacherField = new ButtonField(
      "Origin Teacher", 
      () async {
        originTeacher = await Navigator.push(context, MaterialPageRoute(builder: (context) => new UserSearch(user, '2')));
        originTeacherField.state.setState(() {
          originTeacherField.state.text = originTeacher == null ? "Origin Teacher" : "Origin Teacher: " + originTeacher.getName(); 

        });        
      },
    );
    destinationTeacherField = new ButtonField(
      "Destination Teacher", 
      () async {
        destinationTeacher = await Navigator.push(context, MaterialPageRoute(builder: (context) => new UserSearch(user, '2')));
        destinationTeacherField.state.setState(() {
          destinationTeacherField.state.text = destinationTeacher == null ? "Destination Teacher" : "Destination Teacher: " + destinationTeacher.getName(); 

        });        
      },
    );

    if (user.type == '1') {
      student = user as UserModel;
    } else if (user.type == '2') {
      studentField = new ButtonField(
        "Student", 
        () async {
          student = await Navigator.push(context, MaterialPageRoute(builder: (context) => new UserSearch(user, '1')));
          studentField.state.setState(() {
            studentField.state.text = student == null ? "Student" : "Student: " + student.getName(); 

          });        
        },
      );
    }
  }

  SRTPassModel getData() { 
    return new SRTPassModel(date, student, originTeacher, description, destinationTeacher, session);
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        new Expanded (
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
            child: new Container(
              width: double.infinity,
              padding: EdgeInsets.all(10.0),
              child: Form(
                child: new Column(
                  children: <Widget>[
                    studentField != null ? studentField : new Container(),
                    originTeacherField, 
                    destinationTeacherField, 
                    new DateTimePickerFormField(
                      format: dateFormat,
                      enabled: true,
                      onChanged: (value) {
                        date = value;
                      },

                      decoration: new InputDecoration(
                        hintText: 'Day',         
                        border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.blue))                 
                      )
                    ),

                    new Container(
                      width: 20000.0,
                      padding: EdgeInsets.only(top: 10.0),
                      child: new Dropdown(["First Session", "Second Session", "Both Sessions"], function),
                    ),

                    new TextField(
                      maxLines: 8,
                      onChanged: (value) {
                        description = value;
                      },
                      decoration: new InputDecoration(
                        hintText: 'Description',    
                      )
                    )
                  ],
                )
              ),
            ),
          ),
        ),
      
        new Container(
            margin: EdgeInsets.only(top: 1.25, bottom: 2.5),
            width: 3000.0,
            child: new RaisedButton(
              onPressed: () {
                print("tet");

                if (date != null && student != null && originTeacher != null && description != null && destinationTeacher != null && session != null) {
                  SRTPassModel pass = getData();
                } else {
                  Messages.message("Must fill all fields", context);
                }
              },
              color: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
              child: new Text('Submit'),
            ),
          ),
        ],
    );
  }
}