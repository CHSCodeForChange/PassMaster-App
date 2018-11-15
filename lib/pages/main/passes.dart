import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import './passes/active-passes.dart';
import './passes/passes.dart';
import './passes/pending-passes.dart';
import './passes/old-passes.dart';
import '../../models/currentuser.dart';

class Passes extends StatelessWidget {
  CurrentUserModel user;

  Passes(this.user);

  List<Tab> getTabs() {
    if (user.type == '1'){
      return [
              Tab(text: 'Active'),
              Tab(text: 'Pending'),
              Tab(text: 'Old'),
            ];
    } else if (user.type == '2') {
      return [
        Tab(text: 'Incoming'),
        Tab(text: 'Outgoing'),
        Tab(text: 'Pending'),
        Tab(text: 'Old'),
      ];
    }
  }

  List<Widget> getChildren() {
    if (user.type == '1'){
      return [
              new ActivePasses(user),
              new PendingPasses(user),
              new OldPasses(user),
            ];
    } else if (user.type == '2') {
      return [
        new GenericPasses(user, 'teacher-incoming'),
        new GenericPasses(user, 'teacher-outgoing'),
        new GenericPasses(user, 'teacher-pending'),
        new GenericPasses(user, 'teacher-old'),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: EdgeInsets.only(top:20.0),
      child: DefaultTabController(
        initialIndex: 0,
        length: user.type == '1' ? 3 : 4,
        child: Scaffold(
          appBar: TabBar(
            labelColor: Colors.white,
            tabs: getTabs(),
          ),

          body: TabBarView(
            children: getChildren(),
          ),
        ),
      ),
    );
  }
}