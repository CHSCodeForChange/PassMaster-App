import './user.dart';
import './pass.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import './datetime.dart';


class SRTPassModel extends PassModel {
  UserModel destinationTeacher;
  String session;

  SRTPassModel(
    DateTime date, 
    UserModel student, 
    UserModel originTeacher,
    String description, 
    UserModel destinationTeacher,
     String session
  ) :super(date, getStart(session), getEnd(session),
    student, originTeacher,
    description, "SRTPass", destinationTeacher.getName()) {
      this.destinationTeacher = destinationTeacher;
      this.session = session;
  }

  @override 
  String getDateDuration() {
    return MyDateTime.getDate(date) + ", Session: " + getSession();
  }

  @override 
  String getName() {
    return destinationTeacher.getName();
  }

  @override
  Icon getIcon() {
    return Icon(Icons.hourglass_full);
  }

  String getSession() {
    if (session == null) {
      return "None";
    }
    switch (session) {
      case '1':
        return 'First';
      case '2':
        return 'Second';
      case '3':
        return 'Both';
    }
  }

  static TimeOfDay getStart(String session) {
    switch(session) {
      case "1":
        return TimeOfDay(hour: 9, minute: 30);
      case "2":
        return TimeOfDay(hour: 10, minute: 20);
      case "3":
        return TimeOfDay(hour: 9, minute: 30);
    }
  }

  static TimeOfDay getEnd(String session) {
    switch(session) {
      case "1":
        return TimeOfDay(hour: 10, minute: 20);
      case "2":
        return TimeOfDay(hour: 11, minute: 3);
      case "3":
      return TimeOfDay(hour: 11, minute: 3);
    }
  }

  Map<String, dynamic> toJson() =>
    {
      'date' : MyDateTime.getDateJson(date), 
      'student' : student.pk, 
      'originTeacher' : originTeacher.toJson(),
      'description' : description, 
      'destinationTeacher' : destinationTeacher.toJson(),
      'session': session
    };

  SRTPassModel.fromJson(Map<String, dynamic> json) :super.fromJson(json) {
    this.destinationTeacher = UserModel.fromJson(json['destinationTeacher']);
    this.session = json['session'];
  }
}