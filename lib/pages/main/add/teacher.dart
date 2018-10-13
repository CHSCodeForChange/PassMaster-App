import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../models/teacher-pass.dart';
import '../../../models/pass.dart';
import '../../../models/currentuser.dart';

import '../../../fragments/form/date-picker.dart';
import '../../../fragments/form/time-picker.dart';
import '../../../fragments/messages.dart';
import '../../../fragments/form/user-picker.dart';
import '../../../fragments/form/field2.dart';

import '../../../api/create.dart';
import '../passes/view-pass.dart';

class TeacherPassForm extends StatefulWidget {
  CurrentUserModel user;

  TeacherPassForm(this.user);

  @override
  TeacherPassFormState createState() => new TeacherPassFormState(user);
}

class TeacherPassFormState extends State<TeacherPassForm> {
 

  CurrentUserModel user;

  MyDatePicker date = new MyDatePicker("Date");
  MyTimePicker startTime = new MyTimePicker("Start Time");
  MyTimePicker endTime = new MyTimePicker("End Time");
  MyField2 description =  new MyField2("Description", 8);

  UserPicker originTeacher;
  UserPicker destinationTeacher;
  UserPicker student; 

  TeacherPassFormState(CurrentUserModel user) {
    this.user = user;

    originTeacher = new UserPicker(user, 'Origin Teacher', '2');
    destinationTeacher = new UserPicker(user, 'Destination Teacher', '2');
    
    if (user.type == '2') { // create student field if the current user isn't a student
      student = new UserPicker(user, 'Student', '1');
    }
  }

  PassModel getData() {
    return new TeacherPassModel(date.getValue(), startTime.getValue(), endTime.getValue(), student == null ? user : student.getValue(), originTeacher.getValue(), description.getValue(), destinationTeacher.getValue());
  }

  @override
  Widget build(BuildContext context) {
     List<Widget> widgets = [
      student != null ? student : new Container(),
      originTeacher, 
      destinationTeacher, 
      date,
      startTime,
      endTime,
      description
    ];

    return new Column(
      children: <Widget>[
        new Expanded (
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
            child: new Container(
              width: double.infinity,
              padding: EdgeInsets.only(left:10.0, right:10.0),
              child: new Container(
                alignment: Alignment.topLeft,
                child: ListView.builder(
                  padding: EdgeInsets.all(0.0),
                  itemCount: widgets.length,
                  itemBuilder: (BuildContext context, int index) {
                    return widgets[index];
                  }
                ),       
              )
            ),
          ),
        ),
      
        new Container(
            margin: EdgeInsets.only(top: 1.25, bottom: 2.5),
            width: 3000.0,
            child: new RaisedButton(
              onPressed: () async {
                // give error if all fields aren't filled in
                if ((student != null && student.isEmpty()) || originTeacher.isEmpty() || date.isEmpty() || startTime.isEmpty() || endTime.isEmpty() || description.isEmpty() || destinationTeacher.isEmpty()) {
                  Messages.error("Must fill all fields", context);
                } else {
                  // otherwise create an object
                  TeacherPassModel pass = getData();
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