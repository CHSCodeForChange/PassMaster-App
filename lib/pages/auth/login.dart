import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../main/main.dart';
import './signup.dart';
import '../../api/login.dart';
import '../../models/currentuser.dart';
import '../../models/storage.dart';
import '../../fragments/form/field.dart';
import '../../fragments/button.dart';
import '../../fragments/messages.dart';
import 'package:flutter/services.dart';


class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.orangeAccent,
      body: new LoginBody(),
    );
  }
}

class LoginBody extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  MyField username, password;
  bool loggingIn = false;


  LoginBody () {
    username = MyField('username', false);
    password = MyField('password', true);
  }


  void login(BuildContext context) async {
    if (_formKey.currentState.validate() && !loggingIn) {
      loggingIn = true;
      _formKey.currentState.save();

      CurrentUserModel user;
      try {
        Messages.message("Logging in...", context);
        user = await LoginAPI().getData(username.value, password.value);
        Storage().storeUser(user);
        Navigator.push(context, MaterialPageRoute(builder: (context) => Main(user)));
        Messages.clear(context);
        this._formKey.currentState.reset();
      } catch (e) {
        Messages.error(e.toString(), context);
      }
      loggingIn = false;
    }
  }
 
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.orangeAccent,
      statusBarColor: Colors.transparent,
    ));
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Container(
          child: new Text(
            'PassMaster',
            style: TextStyle(color: Colors.white, fontSize: 50.0, fontWeight: FontWeight.bold),
          )
        ),
        new Container(
          margin: EdgeInsets.all(20.0),
          child: new Form(
            key: _formKey,
            child: new Column(
              children: <Widget>[
                new Container(
                  margin: EdgeInsets.all(10.0),
                  child: username,
                ),
                new Container(
                  margin: EdgeInsets.all(10.0),
                  child: password,
                ), 
              ],
            ),
          )
        ),
        new Container(
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Container(
                margin: EdgeInsets.all(5.0),
                child: MyButton('Log In', () {
                  login(context);
                })
              ),
              new Container(
                margin: EdgeInsets.all(5.0),
                child: new MyButton('Sign Up', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Signup()),
                  );  
                })
              ),
            ],
          ),
        ),
        new Container(
          child: new Text(
            'Code For Change 2018',
            style: TextStyle(color: Colors.white),
          )
        )
      ],
    );
  }
}