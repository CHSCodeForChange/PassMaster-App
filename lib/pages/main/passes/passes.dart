import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';

import '../../../fragments/pass-list.dart';
import '../../../api/pass_list.dart';
import '../../../models/pass.dart';
import '../../../models/currentuser.dart';
import './view-pass.dart';

class GenericPasses extends StatefulWidget {
  CurrentUserModel user;
  String list_type;

  GenericPasses(this.user, this.list_type);

  @override
  GenericPassesState createState() => new GenericPassesState(user, list_type);

}

class GenericPassesState extends State<GenericPasses> {
  CurrentUserModel user;
  String list_type;
  PassList list;

  GenericPassesState(this.user, this.list_type);

  @override 
  void initState() {
    list = new PassList(null, user);
    getData();
  }

  Future<void> getData() async {
    Iterable<PassModel> passes = await PassListAPI().getData(user.token, list_type);
    list.update(passes);
  }

  @override
  Widget build(BuildContext context) {
    return list;
  }
}





