import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../pages/main/passes/view-pass.dart';

import '../models/pass.dart';
import '../models/currentuser.dart';

import '../components/ui/loader.dart';
import './pass-mini.dart';

class PassList extends StatefulWidget {
  PassListState state;
  Iterable<PassModel> passes;
  CurrentUserModel user;
  
  void update(Iterable<PassModel> passes) {
    this.passes = passes;
    if (state.mounted) {
      state.setState(() {
        state.passes = passes;
      });
    }
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
    if (passes == null) {
      return new Center(
        child: new Loader(false)
      );
    }
    return passes?.length==0 ?? false ? Center(child: Text('No passes in this list.', style: TextStyle(color: Colors.white, fontSize: 26.0),)) : new ListView.builder(
      padding: new EdgeInsets.all(8.0),
      itemExtent: 120.0,
      itemCount: passes?.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        return new GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => new ViewPass(user, passes.elementAt(index))));
          },
          child: new PassMini(passes.elementAt(index), user),
        );
      },
    );
  }
}