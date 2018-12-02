import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../fragments/pass.dart';
import '../../models/currentuser.dart';
import '../../models/pass.dart';
import '../../api/pass.dart';
import '../../utilities/storage.dart';
import '../../fragments/scanner.dart';
import '../auth/login.dart';

class Home extends StatefulWidget {
  CurrentUserModel user;
  Home(this.user);

  @override
  HomeState createState() => new HomeState(user);
}

class HomeState extends State<Home> {
  CurrentUserModel user;
  Pass pass;

  HomeState(this.user);

  @override
  void initState() {
    pass = new Pass(this.user, null);
    getData();
  }

  Future<void> getData() async {

    PassModel _pass = await PassAPI().getTop(user.token);

    pass.state.setState(() {
      pass.state.pass = _pass;
    });
    pass.state.getPass();

  }

  @override
  Widget build(BuildContext context) {

    return new Container(
      child: new Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orangeAccent,
          title: new Row(
            children: <Widget>[
              new Icon(
                Icons.person,
                size: 20.0,
                color: Colors.white,
              ),
              new Text(
                ' ' + this.user.firstname + ' ' + this.user.lastname,
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              )
            ],
          ),
          actions: <Widget>[
            // user.type == '2' ? IconButton(
            //   icon: Icon(Icons.camera),
            //   onPressed: () {
            //     Navigator.push(context, new MaterialPageRoute(builder: (context) => new Scanner(user)));
            //   },
            // ) : new Container(),

            new IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                Storage().removeUser();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));     
              },
            ),
          ],
        ),
        body: new Container(
          padding: EdgeInsets.all(20.0),
          child: pass,
        ),
      )
    );
  }
}