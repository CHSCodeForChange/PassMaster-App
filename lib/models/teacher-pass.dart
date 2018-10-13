import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import './user.dart';
import './pass.dart';
import 'datetime.dart';


class TeacherPassModel extends PassModel {
  UserModel destinationTeacher;

  TeacherPassModel(
    DateTime date, 
    TimeOfDay startTimeRequested, 
    TimeOfDay endTimeRequested, 
    UserModel student, 
    UserModel originTeacher,
    String description, 
    UserModel destinationTeacher
  ) 
  :super(date, startTimeRequested, endTimeRequested,
    student, originTeacher,
    description, "TeacherPass", destinationTeacher.getName()) {
      this.destinationTeacher = destinationTeacher;
  }

  TeacherPassModel.fromJson(Map<String, dynamic> json) :super.fromJson(json) {
    this.destinationTeacher = UserModel.fromJson(json['destinationTeacher_info']);
  }

  Map<dynamic, dynamic> toJson() =>
    {
      'date' : MyDateTime.getDateJson(date), 
      'student' : student.pk.toString(), 
      'originTeacher' : originTeacher.pk.toString(),
      'description' : description, 
      'destinationTeacher' : destinationTeacher.pk.toString(),
      'startTimeRequested': MyDateTime.getTimeJson(startTimeRequested),
      'endTimeRequested': MyDateTime.getTimeJson(endTimeRequested),
    };

  @override 
  String getName() {
    return destinationTeacher.getName();
  }

  @override
  Icon getIcon() {
    return Icon(Icons.person);
  }
}