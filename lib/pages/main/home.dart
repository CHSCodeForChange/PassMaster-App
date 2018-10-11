import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';

import '../../fragments/header.dart';
import '../../fragments/pass/pass.dart';
import '../../models/currentuser.dart';
import '../../models/pass.dart';
import '../../api/pass_list.dart';

class Home extends StatefulWidget {
  CurrentUserModel user;
  Home(this.user);

  @override
  HomeState createState() => new HomeState(user);
}

class HomeState extends State<Home> {
  CurrentUserModel user;
  Pass pass;

  HomeState(this.user);

  @override
  void initState() {
    pass = new Pass(null);
    getData();
  }

  Future<void> getData() async {
    Iterable<PassModel> passes = await PassListAPI().getData(user.token, null);

    pass.state.setState(() {
      pass.state.pass = passes.elementAt(0);
      print(passes.elementAt(0));
    });

  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Column(
        children: <Widget>[
          new Container(
                  margin: EdgeInsets.only(top:20.0, left: 25.0),
                  child: Header(user)
          ),
          new Flexible(
            child: new Container(
              padding: EdgeInsets.all(20.0),
//              child: new Pass(PassModel.testModel()),
              child: pass,
            ),
          )
        ],
      ),
    );
  }
}