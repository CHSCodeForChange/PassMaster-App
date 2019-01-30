import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

import './user.dart';
import './pass.dart';
import 'datetime.dart';
import 'currentuser.dart';

class LocationPassModel extends PassModel {
  String location;

  LocationPassModel(
    DateTime date,
    TimeOfDay startTimeRequested,
    TimeOfDay endTimeRequested,
    UserModel student, 
    UserModel originTeacher,
    String description, 
    String location
  ) 
  :super(date, startTimeRequested, endTimeRequested,
    student, originTeacher,
    description, "LocationPass", location) {
      this.location = location;
  }

  LocationPassModel.fromJson(Map<String, dynamic> json) :super.fromJson(json) {
    this.location = json['location'];

    type = "LocationPass";
  }

  Map<String, dynamic> toJson() =>
    {
      'date' : MyDateTime.getDateJson(date), 
      'student' : student.pk.toString(), 
      'originTeacher' : originTeacher.pk.toString(),
      'description' : description, 
      'location' : location,
      'startTimeRequested': MyDateTime.getTimeJson(startTimeRequested),
      'endTimeRequested': MyDateTime.getTimeJson(endTimeRequested),
    };

  @override 
  String getName(CurrentUserModel user) {
    return user.type == '1' ? location : student.getName();
  }

  @override
  String getDestination() {
    return location;
  }

  @override
  Icon getIcon({childIcon: false}) {
    return Icon(Icons.location_on);
  }
}