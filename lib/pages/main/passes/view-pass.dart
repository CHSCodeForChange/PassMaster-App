import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../fragments/pass.dart';
import '../../../models/pass.dart';
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

  Pass pass;

  ViewPassState(this.user, this.pass_data);

  @override 
  void initState() {
    pass = new Pass(this.user, pass_data);
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      color: Colors.orangeAccent,
      child: new Scaffold(
        backgroundColor: Colors.orangeAccent,
        appBar: new AppBar(
          elevation: 0.0,
          backgroundColor: Colors.orangeAccent,
        ),
        body: new Container(
          alignment: Alignment.topCenter,
          padding: new EdgeInsets.only(top: 0.0, bottom: 50.0, left: 25.0, right: 25.0),
          child: pass,
        )
      )
    );
  }
}