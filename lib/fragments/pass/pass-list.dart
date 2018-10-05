import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import './pass-mini.dart';
import '../../models/pass.dart';
import '../../models/currentuser.dart';
import '../../pages/main/passes/view-pass.dart';



class PassList extends StatefulWidget {
  PassListState state;
  Iterable<PassModel> passes;
  CurrentUserModel user;
  
  void update(Iterable<PassModel> passes) {
    this.passes = passes;
    state.setState(() {
      state.passes = passes;
    });
  }

  PassList(this.passes, this.user);

  @override
  PassListState createState() => new PassListState(this, passes, user); 
}

class PassListState extends State<PassList> {
  Iterable<PassModel> passes;
  CurrentUserModel user;

  PassListState(PassList parent, Iterable<PassModel> passes, CurrentUserModel user) {
    this.passes = passes;
    this.user = user;
    parent.state = this;
  }


  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      padding: new EdgeInsets.all(8.0),
      itemExtent: 100.0,
      itemCount: passes != null ? passes.length : 0,
      itemBuilder: (BuildContext context, int index) {
        return new GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => new ViewPass(user, passes.elementAt(index))));
          },
          child: new PassMini(passes.elementAt(index)),
        );
      },
    );
  }
}