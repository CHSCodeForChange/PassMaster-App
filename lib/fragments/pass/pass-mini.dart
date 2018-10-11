import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../models/pass.dart';

class PassMini extends StatelessWidget {
  PassModel pass;

  PassMini(this.pass);

  @override
  Widget build(BuildContext context) {
    Icon icon;
    if(pass.type == "SRTPass") {
      icon = new Icon(Icons.hourglass_full);
    }
    else if(pass.type == "LocationPass") {
      icon = new Icon(Icons.location_on);
    }
    else if(pass.type == "TeacherPass") {
      icon = new Icon(Icons.person);
    }
    return new Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
      child: new Container(
        padding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 20.0, right: 20.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Row(
              children: <Widget>[
                new Container(
                  child: icon,
                  padding: EdgeInsets.only(right: 10.0),
                ),
                new Text(
                  pass.destination,
                  style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                ),
              ],
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