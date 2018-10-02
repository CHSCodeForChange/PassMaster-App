import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import './passes/current-passes.dart';
import './passes/unapproved-passes.dart';
import './passes/search-pass-list.dart';
import '../../models/currentuser.dart';

class Passes extends StatelessWidget {
  CurrentUserModel user;

  Passes(this.user);

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: EdgeInsets.only(top:20.0),
      child: DefaultTabController(
        initialIndex: 1,
        length: 3,
        child: Scaffold(
          appBar: TabBar(
            labelColor: Colors.white,
            tabs: [
              // Tab(icon: Icon(Icons.search)),
              Tab(text: 'Current'),
              // Tab(text: 'Unapproved'),
            ],
          ),

          body: TabBarView(
            children: [
              // new SearchPassList(user),
              new CurrentPasses(user),
              // new UnapprovedPasses(user),
            ],
          ),
        ),
      ),
    );
  }
}