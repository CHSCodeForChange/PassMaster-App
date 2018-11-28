import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../models/user.dart';
import '../utilities/storage.dart';
import '../pages/auth/login.dart';

class Header extends StatelessWidget {  
  UserModel user;

  Header(this.user);

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      child: new Container(
        child: Row(
          children: <Widget>[
            new Container(
              margin: EdgeInsets.all(5.0),
              child:new Icon(
                Icons.person,
                size: 20.0,
                color: Colors.white,
              )
            ),
            new Container(
              margin: EdgeInsets.all(5.0),
              child:new Text(
                this.user.firstname + ' ' + this.user.lastname,
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              )
            ),
            new Expanded(
              child: new IconButton(
                icon: Icon(Icons.exit_to_app),
                color: Colors.red,
                iconSize: 30.0,
                onPressed: () {
                  Storage().removeUser();
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));     
                },
              ),
            )
          ],
        ),
      ) 
    );
  }
}