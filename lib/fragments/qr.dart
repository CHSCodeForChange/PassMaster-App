import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../models/pass.dart';

class QR extends StatefulWidget {
  PassModel pass;

  QR(this.pass);

  @override
  QRState createState() => new QRState(this.pass);

}

class QRState extends State<QR> {
  PassModel pass;

  QRState(this.pass);

  String getData() {
    String pk = pass.pk.toString();
    String type = pass.type;
    // String type = pass.getType() != null ? pass.getType() : "";
    // String action = pass.nextAction();

    String data = pk+","+type;
    return data;
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold( 
      backgroundColor: Colors.orangeAccent,
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
      ),
      body: new Container(
        padding: EdgeInsets.all(20.0),
        child: new Card(
          child: new Container(
            width: double.infinity,
            height: double.infinity,
            padding: EdgeInsets.all(20.0),
            alignment: Alignment.center,
            child: new QrImage(
              data: getData(),
            ),
          )
        )
      ),
    );
  }

}