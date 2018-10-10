import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../fragments/header.dart';
import '../../fragments/pass/pass.dart';
import '../../models/currentuser.dart';
import '../../models/pass.dart';

class Home extends StatelessWidget {
  CurrentUserModel user;

  Home(this.user);

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Column(
        children: <Widget>[
          // new Container(
          //   margin: EdgeInsets.only(top:20.0, left: 25.0),
          //   child: Header(user)
          // ),
          new Flexible(
            child: new Container(
              padding: EdgeInsets.all(20.0),
              child: new Pass(PassModel.testModel()),
            ),
          )
        ],
      ),
    );
  }
}