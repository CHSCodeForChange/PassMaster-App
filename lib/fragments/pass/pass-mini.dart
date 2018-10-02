import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../models/pass.dart';

class PassMini extends StatelessWidget {
  PassModel pass;

  PassMini(this.pass);

  @override
  Widget build(BuildContext context) {
    return new Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
      child: new Container(
        padding: EdgeInsets.all(10.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text(
              pass.student.getName(),
              style: TextStyle(fontSize: 35.0, fontWeight: FontWeight.bold),
            ),
            new Text(
              pass.getDateDuration(),
              style: TextStyle(fontSize: 17.0),
            )
          ],
        ),
      ),
    );
  }
}