import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:datetime_picker_formfield/time_picker_formfield.dart';

class LocationPassForm extends StatelessWidget {
  final dateFormat = DateFormat("EEEE, MMMM d, yyyy");
  final timeFormat = DateFormat.jm();

  @override
  Widget build(BuildContext context) {
    return new Form(
      child: new Column(
        children: <Widget>[
          new TextFormField(
            decoration: new InputDecoration(
              hintText: 'Origin Teacher',                          
            )
          ),
          new TextFormField(
            decoration: new InputDecoration(
              hintText: 'Location',                          
            )
          ),
          new DateTimePickerFormField(
            format: dateFormat,
            enabled: true,
            decoration: new InputDecoration(
              hintText: 'Day',                          
            )
          ),
          new TimePickerFormField(
            format: timeFormat,
            enabled: true,
            decoration: new InputDecoration(
              hintText: 'Start',                          
            )
          ),
          new TimePickerFormField(
            format: timeFormat,
            enabled: true,
            decoration: new InputDecoration(
              hintText: 'End',                          
            )
          ),
          new TextFormField(
            maxLines: 6,
            decoration: new InputDecoration(
              hintText: 'Description',                          
            )
          )
        ],
      )
    );
  }
}