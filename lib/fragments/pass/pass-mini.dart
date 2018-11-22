import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../models/pass.dart';

class PassMini extends StatelessWidget {
  PassModel pass;

  PassMini(this.pass);

  @override
  Widget build(BuildContext context) {
    return new Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: new Container(
        padding: EdgeInsets.only(top: 15.0, bottom: 15.0, left: 20.0, right: 20.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Row(
              children: <Widget>[
                new Container(
                  child: this.pass.getIcon(childIcon: true),
                  padding: EdgeInsets.only(right: 10.0),
                ),
                new Text(
                  pass.destination,
                  style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),

            new Text(
              pass.getDateDuration(showYear: false, shortenedMonths: true),
              style: TextStyle(fontSize: 17.0),
            )
          ],
        ),
      ),
    );
  }
}