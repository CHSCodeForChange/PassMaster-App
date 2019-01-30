import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../fragments/pass.dart';
import '../../models/currentuser.dart';
import '../../models/pass.dart';
import '../../api/pass.dart';
import '../../utilities/storage.dart';
import '../../fragments/scanner.dart';
import '../auth/login.dart';
import 'package:qr_reader/qr_reader.dart';
import '../../utilities/messages.dart';

class Home extends StatefulWidget {
  CurrentUserModel user;
  Home(this.user);

  @override
  HomeState createState() => new HomeState(user);
}

class HomeState extends State<Home> {
  CurrentUserModel user;
  Pass pass;
  // hasPass is used to stop the loading animation if there are no passes in the list
  bool hasPass = true;

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
    if(pass.state.pass != null) {
      pass.state.getPass();
    } else {
      hasPass = false;
    }
  }

  void scan(BuildContext context) async {
    String code = await new QRCodeReader().scan();
    List<String> data = code.split(",");
    int pk = int.parse(data.elementAt(0));
    String type = data.elementAt(1);

    PassModel pass = await PassAPI().getData(user.token, pk, type, null);

    print(pass);

    if (pass != null && pass.nextActionByMe() != null) {
      if (pass.nextActionByMe() != null) {
        await PassAPI().getData(user.token, pk, type, pass.nextActionByMe());
        String message;

        if (pass.nextActionByMe() == "approve") {
          message = "Approved";
        } else if (pass.nextActionByMe() == "signout") {
          message = "Signed Out";
        } else if (pass.nextActionByMe() == "signin") {
          message = "Signed In";
        }

        Messages.message(message, context);
      } else {
        Messages.error("No Action Available", context);
      }  
    } else {
      Messages.error("No Permissions", context);
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Color.fromARGB(255, 250, 250, 250),
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
    ));
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
            user.type == '2' ? IconButton(
              icon: Icon(Icons.camera),
              onPressed: () {
                scan(context);
              },
            ) : new Container(),

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
          child: hasPass ? pass:new Center(child: new Text('No passes for this user.', style: TextStyle(color: Colors.white, fontSize: 26.0))),
        ),
      )
    );
  }
}