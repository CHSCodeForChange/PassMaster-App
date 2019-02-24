import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import './passes/active-passes.dart';
import './passes/passes.dart';
import './passes/pending-passes.dart';
import './passes/old-passes.dart';
import './passes/calendar.dart';
import '../../models/currentuser.dart';

class Passes extends StatelessWidget {
  CurrentUserModel user;

  Passes(this.user);

  List<Tab> getTabs() {
    if (user.isStudent()){
      return [
              Tab(text: 'Active'),
              Tab(text: 'Pending'),
              Tab(text: 'Old'),
            ];
    } else if (user.isTeacher()) {
      return [
        Tab(text: 'Incoming'),
        Tab(text: 'Outgoing'),
        Tab(text: 'Pending'),
        Tab(text: 'Old'),
      ];
    } else if (user.isLocation()) {
      return [
        Tab(text: 'Incoming'),
        Tab(text: 'Old'),
      ];
    }
    return null;
  }

  List<Widget> getChildren() {
    if (user.isStudent()){
      return [
        new ActivePasses(user),
        new PendingPasses(user),
        new OldPasses(user),
      ];
    } else if (user.isTeacher()) {
      return [
        new GenericPasses(user, 'teacher-incoming'),
        new GenericPasses(user, 'teacher-outgoing'),
        new GenericPasses(user, 'teacher-pending'),
        new GenericPasses(user, 'teacher-old'),
      ];
    } else if (user.isLocation()) {
      return [
        new GenericPasses(user, 'teacher-incoming'),
        new GenericPasses(user, 'teacher-outgoing')
      ];
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Color.fromARGB(255, 250, 250, 250),
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
    ));
    return new Container(
      margin: EdgeInsets.only(top:20.0),
      child: DefaultTabController(
        initialIndex: 0,
        length: user.isStudent() ? 3 : 4,
        child: Scaffold(
          appBar: TabBar(
            labelColor: Colors.white,
            indicatorColor: Colors.white,
            indicatorWeight: 3.0,
            tabs: getTabs(),
          ),
          floatingActionButton: new FloatingActionButton(
            child: new Icon(Icons.calendar_today),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => new MyCalendar(user)));
            },
          ),
          body: TabBarView(
            children: getChildren(),
          ),
        ),
      ),
    );
  }
}