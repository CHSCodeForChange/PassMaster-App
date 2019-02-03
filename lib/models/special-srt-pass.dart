import './user.dart';
import './srt-pass.dart';
import './datetime.dart';

import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';


class SpecialSRTPassModel extends SRTPassModel {
  UserModel initiatingTeacher;


  SpecialSRTPassModel(
    DateTime date, 
    UserModel student, 
    UserModel originTeacher,
    UserModel initiatingTeacher,
    String description, 
    UserModel destinationTeacher,
     String session
  ) :super(date, student, originTeacher, description, destinationTeacher, session) {
      this.initiatingTeacher = initiatingTeacher;
      type = "SpecialSRTPass";
  }

  Map<String, dynamic> toJson() =>
    {
      'date' : MyDateTime.getDateJson(date), 
      'student' : student.pk.toString(), 
      'originTeacher' : originTeacher.pk.toString(),
      'initiatingTeacher' : initiatingTeacher.pk.toString(),
      'description' : description, 
      'destinationTeacher' : destinationTeacher.pk.toString(),
      'session': session
    };

  SpecialSRTPassModel.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    this.initiatingTeacher = UserModel.fromJson(json['initiatingTeacher_info']);
    type = "SpecialSRTPass";
  }

  @override
  Icon getIcon({childIcon = false}) {
    return  Icon(Icons.local_library);
  }
}