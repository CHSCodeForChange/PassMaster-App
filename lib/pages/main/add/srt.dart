import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class SRTPassForm extends StatelessWidget {
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
              hintText: 'Destination Teacher',                          
            )
          ),
          new DateTimePickerFormField(
            format: dateFormat,
            enabled: true,
            decoration: new InputDecoration(
              hintText: 'Day',                          
            )
          ),
          new TextFormField(
            decoration: new InputDecoration(
              hintText: 'Session',                          
            )
          ),
          new TextFormField(
            maxLines: 8,
            decoration: new InputDecoration(
              hintText: 'Description',                          
            )
          )
        ],
      )
    );
  }
}