import './user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import './datetime.dart';
import './currentuser.dart';

class PassModel {
  int pk;
  bool approved;
  DateTime date;
  TimeOfDay startTimeRequested, endTimeRequested, timeLeftOrigin, timeArrivedDestination;
  UserModel student, originTeacher;
  String description;
  String type;
  String destination;
  bool canApprove;
  bool canSignIn;
  bool canSignOut;
  
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
    canApprove = json['can_approve'];
    canSignIn = json['can_sign_in'];
    canSignOut = json['can_sign_out'];
  }

  String getDuration() {
    bool firstWithAMPM = true;
    if(MyDateTime.isPM(startTimeRequested) == MyDateTime.isPM(endTimeRequested)) {
      firstWithAMPM = false;
    }
    return MyDateTime.getTime(startTimeRequested, withAMPM: firstWithAMPM) + "-" + MyDateTime.getTime(endTimeRequested);
  }

  String getDateDuration({showYear: true, shortenedMonths: false}) {
    return MyDateTime.getDate(date, showYear: showYear, shortenedMonths: shortenedMonths) + ", " + getDuration();
  }

  String getName(CurrentUserModel user) {
    return user.type == '1' ? destination : student.getName();
  }

  String getDestination() {
    return destination;
  }

  Icon getIcon({childIcon: false}) {
    if(!childIcon) {
      return Icon(Icons.layers);
    }
    if(type == "SRTPass") {
      return new Icon(Icons.hourglass_full);
    }
    else if(type == "LocationPass") {
      return new Icon(Icons.location_on);
    }
    else if(type == "TeacherPass") {
      return new Icon(Icons.person);
    }
    else {
      return Icon(Icons.error);
    }

  }

  String nextAction() {
    if (!approved) {
      return "approve";
    } else if (timeLeftOrigin == null) {
      return "signout";
    } else if (timeArrivedDestination == null) {
      return "signin";
    } else {
      return null;
    }
  }
  
}