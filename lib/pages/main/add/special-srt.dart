import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../api/create.dart';

import '../../../models/special-srt-pass.dart';
import '../../../models/pass.dart';
import '../../../models/currentuser.dart';

import '../../../utilities/messages.dart';

import '../../../components/form/date-picker.dart';
import '../../../components/ui/dropdown.dart';
import '../../../components/form/user-picker.dart';
import '../../../components/form/field2.dart';
import '../passes/view-pass.dart';


class SpecialSRTPassForm extends StatefulWidget {
  CurrentUserModel user;

  SpecialSRTPassForm(this.user);

  @override
  SpecialSRTPassFormState createState() => new SpecialSRTPassFormState(user);
}

class SpecialSRTPassFormState extends State<SpecialSRTPassForm> {
  CurrentUserModel user;

  MyDatePicker date = new MyDatePicker("Date");
  Dropdown session = new Dropdown(["First Session", "Second Session", "Both Sessions"], values: ['1', '2', '3']);
  MyField2 description =  new MyField2("Description", 8);

  UserPicker originTeacher;
  UserPicker initiatingTeacher;
  UserPicker destinationTeacher;
  UserPicker student; 

  SpecialSRTPassFormState(CurrentUserModel user) {
    this.user = user;

    originTeacher = new UserPicker(user, 'Origin Teacher', '2');
    destinationTeacher = new UserPicker(user, 'Location', '4');
    initiatingTeacher = new UserPicker(user, 'Initiating Teacher', '2');
    
    if (user.isTeacher()) { // create student field if the current user isn't a student
      student = new UserPicker(user, 'Student', '1');
    }
  }

  PassModel getData() {
    return new SpecialSRTPassModel(date.getValue(), student == null ? user : student.getValue(), originTeacher.getValue(), initiatingTeacher.getValue(), description.getValue(), destinationTeacher.getValue(), session.getValue());
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [
      student != null ? student : new Container(),
      originTeacher, 
      initiatingTeacher,
      destinationTeacher, 
      date,
      session,
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
                if ((student != null && student.isEmpty()) || originTeacher.isEmpty() || date.isEmpty() || description.isEmpty() || destinationTeacher.isEmpty()) {
                  print(originTeacher.getValue());
                  print(date.getValue());
                  print(description.getValue());
                  print(destinationTeacher.getValue());
                  Messages.error("Must fill all fields", context);
                } else {
                  // otherwise create an object
                  SpecialSRTPassModel pass = getData();
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