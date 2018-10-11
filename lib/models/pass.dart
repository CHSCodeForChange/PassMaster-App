import './user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PassModel {
  int pk;
  bool approved;
  DateTime date;
  Duration startTimeRequested, endTimeRequested, timeLeftOrigin, timeArrivedDestination;
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
      Duration(),
      Duration(), 
      Duration(),
      Duration(),
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
    startTimeRequested = parseTime(json['startTimeRequested']);
    endTimeRequested = parseTime(json['endTimeRequested']);
    timeLeftOrigin = parseTime(json['timeLeftOrigin']);
    timeArrivedDestination = parseTime(json['timeArrivedDestination']);
    student = UserModel.fromJson(json['student']);
    originTeacher = UserModel.fromJson(json['originTeacher']);
    description = json['description']; 
    type = json['type'];
    destination = json['destination'];
  }

  String getDate() {
    return getMonthName(date.month) + " " + date.day.toString() + ", " + date.year.toString();
  }

  String getDateJson() {
    return date.year.toString() + "-" + date.month.toString() + "-" + date.day.toString();
  }

  String getDuration() {
    return getTime(startTimeRequested) + "-" + getTime(endTimeRequested);
  }

  String getDateDuration() {
    return getDate() + ", " + getDuration();
  }

  String getTime(Duration duration) {
    return duration == null ? "" : duration.inHours.toString() + ":" + (duration.inMinutes%60<10 ? "0"+(duration.inMinutes%60).toString() : (duration.inMinutes%60).toString());
  }

  String getName() {
    return destination;
  }

  Icon getIcon() {
    return Icon(Icons.layers);
  }

  String getMonthName(int month) {
    switch(month) {
      case 1:
        return "January";
      case 2:
        return "Feburary";
      case 3:
        return "March";
      case 4:
        return "April";
      case 5:
        return "May";
      case 6:
        return "June";
      case 7:
        return "July";
      case 8:
        return "August";
      case 9:
        return "September";
      case 10:
        return "October";
      case 11:
        return "November";
      case 12:
        return "December";
    }
  }


  static Duration parseTime(String time) {
    Duration parsedTime;
    if (time != null) {
      List<String> parts = time.split(":");
      parsedTime =  Duration(
        hours: int.parse(parts.elementAt(0)), 
        minutes: int.parse(parts.elementAt(1)),
        seconds: double.parse(parts.elementAt(2)).toInt()
      );
    } else {
      parsedTime = null;
    }
    return parsedTime;
  }
}