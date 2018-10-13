import './user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import './datetime.dart';

class PassModel {
  int pk;
  bool approved;
  DateTime date;
  TimeOfDay startTimeRequested, endTimeRequested, timeLeftOrigin, timeArrivedDestination;
  UserModel student, originTeacher;
  String description;
  String type;
  String destination;
  
  PassModel(
    this.date,
    this.startTimeRequested, 
    this.endTimeRequested,
    this.student, 
    this.originTeacher, 
    this.description, 
    this.type,
    this.destination,
  );

  PassModel.filled(
    this.pk,
    this.approved,
    this.date,
    this.startTimeRequested, 
    this.endTimeRequested, 
    this.timeLeftOrigin, 
    this.timeArrivedDestination, 
    this.student, 
    this.originTeacher, 
    this.description, 
    this.type,
    this.destination,
  );

  static PassModel testModel() {
    return PassModel.filled(
      0, 
      true, 
      DateTime.now(),
      TimeOfDay(),
      TimeOfDay(), 
      TimeOfDay(),
      TimeOfDay(),
      UserModel.testModel(), 
      UserModel.testModel(), 
      "Description", 
      "SRTPass",
      "Restroom",
    );
  }

  PassModel.fromJson(Map<String, dynamic> json) {
    pk = json['pk'];
    approved = json['approved'];
    date = DateTime.parse(json['date']);
    startTimeRequested = MyDateTime.parseTime(json['startTimeRequested']);
    endTimeRequested = MyDateTime.parseTime(json['endTimeRequested']);
    timeLeftOrigin = MyDateTime.parseTime(json['timeLeftOrigin']);
    timeArrivedDestination = MyDateTime.parseTime(json['timeArrivedDestination']);
    student = UserModel.fromJson(json['student_info']);
    originTeacher = UserModel.fromJson(json['originTeacher_info']);
    description = json['description']; 
    type = json['type'];
    destination = json['destination'];
  }

  String getDuration() {
    return MyDateTime.getTime(startTimeRequested) + "-" + MyDateTime.getTime(endTimeRequested);
  }

  String getDateDuration() {
    return MyDateTime.getDate(date) + ", " + getDuration();
  }

  String getName() {
    return destination;
  }

  Icon getIcon() {
    return Icon(Icons.layers);
  }
}