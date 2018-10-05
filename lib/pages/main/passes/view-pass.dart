import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';

import '../../../api/pass.dart';
import '../../../fragments/pass/pass.dart';
import '../../../models/srt-pass.dart';
import '../../../models/pass.dart';
import '../../../models/teacher-pass.dart';
import '../../../models/location-pass.dart';
import '../../../models/currentuser.dart';

class ViewPass extends StatefulWidget {
  CurrentUserModel user;
  PassModel pass;

  ViewPass(this.user, this.pass);

  @override
  ViewPassState createState() => new ViewPassState(user, pass);

}

class ViewPassState extends State<ViewPass> {
  CurrentUserModel user;
  PassModel pass_data;

  SRTPassModel srt;
  LocationPassModel location;
  TeacherPassModel teacher;

  Pass pass;



  ViewPassState(this.user, this.pass_data);

  @override 
  void initState() {
    getData();
    srt = null;
    teacher = null;
    location = null;
  }

  Future<void> getData() async {
    pass_data = await PassAPI().getData(user.token, pass_data.pk, pass_data.type, null);
    print(pass_data.date);
  }

  Widget getPass() {
    if (srt != null) {
      
    } else if (location != null) {

    } else if (teacher != null) {

    } else {
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}