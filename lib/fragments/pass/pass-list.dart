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
    if (passes == null) {
      return new Column(
        children: <Widget>[
          new Expanded(
            child: new Container(
              alignment: FractionalOffset.center,
              child: new SizedBox(
                width: 75.0,
                height: 75.0,
                child: new CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                  strokeWidth: 5.0,
                ),
              )
            )
          )
        ]
      );
    }
    return passes?.length==0 ?? false ? Center(child: Text('No passes in this list.', style: TextStyle(color: Colors.white, fontSize: 26.0),)) : new ListView.builder(
      padding: new EdgeInsets.all(8.0),
      itemExtent: 100.0,
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