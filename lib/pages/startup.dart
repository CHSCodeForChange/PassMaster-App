import 'package:flutter/material.dart';
import './main/main.dart';
import './auth/login.dart';

import '../models/storage.dart';
import '../models/currentuser.dart';

class Startup extends StatefulWidget {
  
  @override 
  StartupState createState() => new StartupState();
}

class StartupState extends State<Startup> {
  bool finishedQueryingUser = false;
  CurrentUserModel user;

  @override
  void initState() {
    getUser();
    super.initState();
  }

  void getUser() async {
    user = await Storage().getUser();
    setState(() {
      user = user;
      finishedQueryingUser = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!finishedQueryingUser) {
      return new Center(
        child: new SizedBox(
          width: 50.0,
          height: 50.0,
          child: CircularProgressIndicator(),
        ),
      );
    } else if (user == null) {
      return new Login();
    } else {
      return new Main(user);
    }
  }
}