import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../models/srt-pass.dart';
import '../../../models/pass.dart';
import '../../../models/currentuser.dart';

import '../../../fragments/form/date-picker.dart';
import '../../../fragments/messages.dart';
import '../../../fragments/dropdown.dart';
import '../../../fragments/form/user-picker.dart';
import '../../../fragments/form/field2.dart';
import '../passes/view-pass.dart';


import '../../../api/create.dart';

class SRTPassForm extends StatefulWidget {
  CurrentUserModel user;

  SRTPassForm(this.user);

  @override
  SRTPassFormState createState() => new SRTPassFormState(user);
}

class SRTPassFormState extends State<SRTPassForm> {
  CurrentUserModel user;

  MyDatePicker date = new MyDatePicker("Date");
  Dropdown session = new Dropdown(["First Session", "Second Session", "Both Sessions"], values: ['1', '2', '3']);
  MyField2 description =  new MyField2("Description", 8);

  UserPicker originTeacher;
  UserPicker destinationTeacher;
  UserPicker student; 

  SRTPassFormState(CurrentUserModel user) {
    this.user = user;

    originTeacher = new UserPicker(user, 'Origin Teacher', '2');
    destinationTeacher = new UserPicker(user, 'Destination Teacher', '2');
    
    if (user.type == '2') { // create student field if the current user isn't a student
      student = new UserPicker(user, 'Student', '1');
    }
  }

  PassModel getData() {
    return new SRTPassModel(date.getValue(), student == null ? user : student.getValue(), originTeacher.getValue(), description.getValue(), destinationTeacher.getValue(), session.getValue());
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
                    student != null ? student : new Container(),
                    originTeacher, 
                    destinationTeacher, 
                    date, 
        
                    new Container(
                      width: 20000.0,
                      padding: EdgeInsets.only(top: 10.0),
                      child: session,
                    ),

                   description
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
              onPressed: () async {
                // give error if all fields aren't filled in
                if ((student != null && student.isEmpty()) || originTeacher.isEmpty() || date.isEmpty() || description.isEmpty() || destinationTeacher.isEmpty()) {
                  print(originTeacher.getValue());
                  print(date.getValue());
                  print(description.getValue());
                  print(destinationTeacher.getValue());
                  Messages.error("Must fill all fields", context);
                } else {
                  // otherwise create an object
                  SRTPassModel pass = getData();
                  pass = await CreatePassAPI().getData(user.token, pass);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => new ViewPass(user, pass)));
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