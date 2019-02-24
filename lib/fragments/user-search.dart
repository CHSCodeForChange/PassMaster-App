import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';
import '../models/currentuser.dart';
import '../models/user.dart';
import '../api/user-search.dart';
import '../components/ui/loader.dart';

class UserSearch extends StatefulWidget {
  CurrentUserModel user;
  String type;

  UserSearch(this.user, this.type);

  @override
  UserSearchState createState() => new UserSearchState(user, type);
}

class UserSearchState extends State<UserSearch> {
  CurrentUserModel user;
  String type;
  Iterable<UserModel> users;
  String hintText;

  UserSearchState(this.user, this.type);

  @override
  void initState() {
    hintText = "Search Users";
    if(type == "1") {
      hintText = "Search Students";
    }
    else if(type == "2") {
      hintText = "Search Teachers";
    } else if (type == "3") {
      hintText = "Search Administrators";
    } else if (type == "4") {
      hintText = "Search Locations";
    }
    
    getData(null);
  }

  Future<void> getData(String username) async {
    Iterable<UserModel> tempUsers = await UserListAPI().getData(user.token, type, username);
    setState(() {
      users = tempUsers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: new Card(
          color: Colors.orangeAccent,
          elevation: 0.0,
          shape: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          child: new Container(
            padding: EdgeInsets.all(5.0),
            child: new TextField(
              onChanged: (text) => getData(text),
              style: TextStyle(fontSize: 20.0, color: Colors.white),
              cursorColor: Colors.white,
              decoration: InputDecoration.collapsed(
                hintText: hintText,
                hintStyle: TextStyle(fontSize: 20.0, color: Colors.white),
              ),
            )
          ),
        )
      ),
      body: new Container(
        color: Colors.orangeAccent,
        padding: EdgeInsets.all(10.0),
        child: users == null ? new Center(child: new Loader(false)) : ListView.builder(
          itemCount: users == null ? 0 : users.length,
          itemExtent: 75.0,
          itemBuilder: (BuildContext context, int index) {
            return new GestureDetector(
              onTap: () {
                Navigator.pop(context, users.elementAt(index));
              },
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                child: new Container(
                  alignment: Alignment(0.0, 0.0),
                  child: new Text(
                    users.elementAt(index).getName(),
                    style: TextStyle(fontSize: 25.0),
                  ),
                ),
              ),
            );
          },
        ),
      )
    );
  }
}