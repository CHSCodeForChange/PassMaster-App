import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../models/location-pass.dart';
import '../../../models/pass.dart';
import '../../../models/currentuser.dart';

import '../../../fragments/form/date-picker.dart';
import '../../../fragments/form/time-picker.dart';
import '../../../fragments/messages.dart';
import '../../../fragments/form/user-picker.dart';
import '../../../fragments/form/field2.dart';

import '../../../api/create.dart';
import '../passes/view-pass.dart';

class LocationPassForm extends StatefulWidget {
  CurrentUserModel user;

  LocationPassForm(this.user);

  @override
  LocationPassFormState createState() => new LocationPassFormState(user);
}

class LocationPassFormState extends State<LocationPassForm> {
 

  CurrentUserModel user;

  MyDatePicker date = new MyDatePicker("Date");
  MyTimePicker startTime = new MyTimePicker("Start Time");
  MyTimePicker endTime = new MyTimePicker("End Time");
  MyField2 description =  new MyField2("Description", 8);

  UserPicker originTeacher;
  MyField2 location = MyField2("Location");
  UserPicker student; 

  LocationPassFormState(CurrentUserModel user) {
    this.user = user;

    originTeacher = new UserPicker(user, 'Origin Teacher', '2');
    
    if (user.type == '2') { // create student field if the current user isn't a student
      student = new UserPicker(user, 'Student', '1');
    }
  }

  PassModel getData() {
    return new LocationPassModel(date.getValue(), startTime.getValue(), endTime.getValue(), student == null ? user : student.getValue(), originTeacher.getValue(), description.getValue(), location.getValue());
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [
      student != null ? student : new Container(),
      originTeacher, 
      location, 
      date,
      startTime,
      endTime,
      description
    ];

    return new Column(
      children: <Widget>[
        new Expanded (
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
            child: new Container(
              width: double.infinity,
              padding: EdgeInsets.all(20.0),
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
            margin: EdgeInsets.only(top: 1.25, bottom: 2.5, left: 4.0, right: 4.0),
            width: 3000.0,
            child: new RaisedButton(
              onPressed: () async {
                // give error if all fields aren't filled in
                if ((student != null && student.isEmpty()) || originTeacher.isEmpty() || date.isEmpty() || startTime.isEmpty() || endTime.isEmpty() || description.isEmpty() || location.isEmpty()) {
                  Messages.error("Must fill all fields", context);
                } else {
                  // otherwise create an object
                  LocationPassModel pass = getData();
                  pass = await CreatePassAPI().getData(user.token, pass);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => new ViewPass(user, pass)));
                }
              },
              color: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              child: new Text('Submit'),
            ),
          ),
        ],
    );
  }
}