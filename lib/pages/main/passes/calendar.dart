import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_calendar/flutter_calendar.dart';

import '../../../api/pass_list.dart';
import '../../../fragments/pass-list.dart';
import '../../../models/currentuser.dart';
import '../../../models/pass.dart';


class MyCalendar extends StatefulWidget {
  CurrentUserModel user;

  MyCalendar(this.user);

  @override
  MyCalendarState createState() => new MyCalendarState(this.user);

}

class MyCalendarState extends State<MyCalendar> {

  CurrentUserModel user;

  MyCalendarState(this.user);

  PassList list;

  @override
  void initState() {
    list = new PassList([], user);
    super.initState();
  }

  void updateList(DateTime date) async {
    String converted = date.toIso8601String().split('T').elementAt(0);
    Iterable<PassModel> passes = await new PassListAPI().getData(user.token, date: converted);
    list.update(passes);
    this.setState(() {
      list = list;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Calendar'),
      ),
      body: new Column(
        children: <Widget>[
          new Calendar(
            onDateSelected: (date) => updateList(date),
          ),
          new Expanded(
            child: new Container(
              margin: EdgeInsets.only(top: 10.0),
              color: Colors.blue,
              child: list
            ),
          )
        ],
      )
    );

  }
} 