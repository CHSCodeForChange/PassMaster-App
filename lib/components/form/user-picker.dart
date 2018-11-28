import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../models/user.dart';
import '../../models/currentuser.dart';
import '../../components/form/button-field.dart';
import '../../fragments/user-search.dart';

class UserPicker extends StatefulWidget {
  UserPickerState state; 
  CurrentUserModel currentUser;
  String name;
  String type;

  UserModel getValue() {
    return state.user;
  }

  bool isEmpty() {
    return state.user == null;
  }

  UserPicker(this.currentUser, this.name, this.type);

  @override 
  UserPickerState createState() => new UserPickerState(this, currentUser, name, type);
  
}

class UserPickerState extends State<UserPicker> {
  String name;
  String type;
  UserModel user;
  ButtonField field;

  UserPickerState(UserPicker parent, CurrentUserModel currentUser, String name, String type) {
    parent.state = this;
    field = new ButtonField(
      name, 
      () async {
        user = await Navigator.push(context, MaterialPageRoute(builder: (context) => new UserSearch(currentUser, type)));
        field.state.setState(() {
          field.state.text = user == null ? name : name + ": " + user.getName(); 
        });        
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return field;
  }
}