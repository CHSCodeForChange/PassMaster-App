import './user.dart';
import './pass.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import './datetime.dart';
import 'currentuser.dart';


class SRTPassModel extends PassModel {
  UserModel destinationTeacher;
  String session;
  TimeOfDay timeLeftDestination, timeArrivedOrigin;


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
  String getDateDuration({showYear: true, shortenedMonths: false}) {
    return MyDateTime.getDate(date) + ", Session: " + getSession();
  }

  @override 
  String getName(CurrentUserModel user) {
    return user.isStudent() ? destinationTeacher.getName() : student.getName();
  }

  @override
  String getDestination() {
    return destinationTeacher.getName();
  }

  @override
  Icon getIcon({childIcon: false}) {
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
    return "Invalid session value of " + session;
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
    return null;
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
    return null;
  }

  Map<String, dynamic> toJson() =>
    {
      'date' : MyDateTime.getDateJson(date), 
      'student' : student.pk.toString(), 
      'originTeacher' : originTeacher.pk.toString(),
      'description' : description, 
      'destinationTeacher' : destinationTeacher.pk.toString(),
      'session': session
    };

  SRTPassModel.fromJson(Map<String, dynamic> json) :super.fromJson(json) {
    this.destinationTeacher = UserModel.fromJson(json['destinationTeacher_info']);
    this.session = json['session'];
    timeArrivedOrigin = MyDateTime.parseTime(json['timeArrivedOrigin']);
    timeLeftDestination = MyDateTime.parseTime(json['timeLeftDestination']);

    type = "SRTPass";
  }

  @override
  String nextAction() {
    if (!approved) {
      return "approve";
    } else if (timeLeftOrigin == null) {
      return "signout";
    } else if (timeArrivedDestination == null) {
      return "signin";
    } else if (session == '1') {
      if (timeLeftDestination == null) {
      return "signout";
      } else if (timeArrivedOrigin == null) {
        return "signin";
      } 
    } else {
      return null;
    }
  }

  @override
  String nextActionByMe() {
    if (!approved && canApprove) {
      return "approve";
    } else if (timeLeftOrigin == null && canSignOut) {
      return "signout";
    } else if (timeArrivedDestination == null && canSignIn) {
      return "signin";
    } else if (timeLeftDestination == null && canSignIn) {
      return "signout";
    } else if (timeArrivedOrigin == null && canSignOut) {
      return "signin";
    } else {
      return null;
    }
  }

  @override
  List<String> getTimes() {
    List<String> times = [];
    if (timeLeftOrigin != null) times.add("Left Origin: " + MyDateTime.getTime(timeLeftOrigin));
    if (timeArrivedDestination != null) times.add("Arrived Destination: " + MyDateTime.getTime(timeArrivedDestination));
    if (timeLeftDestination != null) times.add("Left Destination: " + MyDateTime.getTime(timeLeftDestination));
    if (timeArrivedOrigin != null) times.add("Arrived Origin: " + MyDateTime.getTime(timeArrivedOrigin));
    return times;
  }
}