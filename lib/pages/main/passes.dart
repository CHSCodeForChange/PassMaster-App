import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import './passes/active-passes.dart';
import './passes/pending-passes.dart';
import './passes/old-passes.dart';
import './passes/unapproved-passes.dart';
import './passes/search-pass-list.dart';
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
      return [];
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
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: EdgeInsets.only(top:20.0),
      child: DefaultTabController(
        initialIndex: 0,
        length: 3,
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