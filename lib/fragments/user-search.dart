import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';
import '../models/currentuser.dart';
import '../models/user.dart';
import '../api/user-search.dart';

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

  UserSearchState(this.user, this.type);

  @override
  void initState() {
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
    return new Material(
      color: Colors.orangeAccent,
      child: Container(
        margin: EdgeInsets.all(15.0),
        child: new Column(
          children: <Widget>[
            new Row(
              children: <Widget>[
                new Container(
                  child: new IconButton(
                    color: Colors.white,
                     icon: Icon(Icons.arrow_back),
                     onPressed: () {
                       Navigator.pop(context);
                     },
                  )
                ),
                new Expanded(
                  child: new Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                    child: new Container(
                      padding: EdgeInsets.all(15.0),
                      child: new TextField(
                        onChanged: (text) => getData(text),
                        decoration: InputDecoration(
                          hintText: "Search Users"
                        ),
                      ),
                    ),
                  )
                )
              ],
            ),
            new Flexible(
              child: ListView.builder(
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
          ],
        )
      ),

    );
  }

}