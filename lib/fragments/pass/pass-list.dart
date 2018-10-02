import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import './pass-mini.dart';
import '../../models/pass.dart';


class PassList extends StatefulWidget {
  PassListState state;
  Iterable<PassModel> passes;

  PassList(this.passes);

  @override
  PassListState createState() => new PassListState(passes, this); 
}

class PassListState extends State<PassList> {
  Iterable<PassModel> passes;

  PassListState(Iterable<PassModel> passes, PassList parent) {
    this.passes = passes;
    parent.state = this;
  }


  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      padding: new EdgeInsets.all(8.0),
      itemExtent: 100.0,
      itemCount: passes != null ? passes.length : 0,
      itemBuilder: (BuildContext context, int index) {
        return new PassMini(passes.elementAt(index));
      },
    );
  }
}