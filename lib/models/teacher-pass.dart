import './user.dart';
import './pass.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


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
    description, "LocationPass", destinationTeacher.getName()) {
      this.destinationTeacher = destinationTeacher;
  }

  TeacherPassModel.fromJson(Map<String, dynamic> json) :super.fromJson(json) {
    this.destinationTeacher = UserModel.fromJson(json['destinationTeacher']);
  }

  Map<String, dynamic> toJson() =>
    {
      'date' : date, 
      'student' : student.pk, 
      'originTeacher' : originTeacher.pk,
      'description' : description, 
      'destinationTeacher' : destinationTeacher,
      'startTimeRequested': startTimeRequested,
      'endTimeRequested': endTimeRequested,
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