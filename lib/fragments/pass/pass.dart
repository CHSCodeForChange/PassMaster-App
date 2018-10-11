import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pass_master/models/location-pass.dart';
import 'package:pass_master/models/srt-pass.dart';
import 'package:pass_master/models/teacher-pass.dart';

import '../../models/pass.dart';

class Pass extends StatefulWidget {
  PassState state;
  PassModel pass;

  Pass(this.pass);

  @override
  PassState createState() => new PassState(this, pass);

}

class PassState extends State<Pass> {
  PassModel pass;

  PassState(Pass parent, PassModel pass) {
    this.pass = pass;
    parent.state = this;
  }

  @override
  Widget build(BuildContext context) {
    String title = "FAILED: PASSMODEL NOT VALID CHILD TYPE";
    List<Widget> descriptors = [];
    TextStyle descriptorStyle = TextStyle(fontStyle: FontStyle.italic, fontSize: 20.0);
    if(pass == null){
      return new Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
        child: new Column(
          children: <Widget>[new Expanded(
            child: new Container(
              height: 600.0, // force card to take up full space
              width: 600.0,
              padding: EdgeInsets.all(25.0),
              alignment: FractionalOffset.center,
              child: new SizedBox(
                width: 75.0,
                height: 75.0,
                child: new CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.orangeAccent),
                  strokeWidth: 5.0,
                ),
              )
            )
          )]
        )
      );
    }
    else {
      descriptors.add(new Row(children: <Widget>[new Text("Origin Teacher: " + (pass?.originTeacher?.getName() ?? ""), style: descriptorStyle)],));
      if(pass.timeLeftOrigin != null) {
        descriptors.add(new Row(children: <Widget>[new Text("Time left origin: " + pass.getTime(pass.timeLeftOrigin), style: descriptorStyle),],));
        pass.getTime(pass.timeLeftOrigin);
      }
      if(pass.timeArrivedDestination != null) {
        descriptors.add(new Row(children: <Widget>[new Text("Time arrived destination: " + pass.timeArrivedDestination.toString(), style: descriptorStyle),],));
      }
    }

    if(pass is LocationPassModel) {
      LocationPassModel loc_pass = pass as LocationPassModel;
      title = loc_pass.location;
    }
    else if (pass is SRTPassModel) {
      SRTPassModel srt_pass = pass as SRTPassModel;
      title = srt_pass.destinationTeacher.getName();
      descriptors.add(new Row(children: <Widget>[new Text("SRT Session: " + srt_pass.session, style: descriptorStyle),],));
    }
    else if (pass is TeacherPassModel) {
      TeacherPassModel teacher_pass = pass as TeacherPassModel;
      title = teacher_pass.destinationTeacher.getName();
    }


    return new Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
      child: new Container(
        height: 500.0, // force card to take up full space
        width: 500.0, 
        padding: EdgeInsets.all(25.0),
        alignment: Alignment.topLeft,
        child: pass == null ? new Container() : Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new Container(
              child: new Text(
                title,
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 35.0, fontWeight: FontWeight.bold),
              ),
            ),
            new Container(
              alignment: Alignment.bottomLeft,
              child: new Text(
                this.pass.getDateDuration(),
                style: TextStyle(color: Colors.grey, fontSize: 20.0),
              ),
            ),
            new Container(
              alignment: Alignment.bottomLeft,
              child: new Column(
                children: descriptors,
              ),
            ),
            new Divider(),
            new Container(
              alignment: Alignment.topLeft,
              child: new Text(
                this.pass.description,
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            new Expanded(
              child: new Container(
                alignment: FractionalOffset.bottomCenter,
                child: new MaterialButton(onPressed: null)
              ),
            )
          ],
        ),
      ),
    );
  }
}