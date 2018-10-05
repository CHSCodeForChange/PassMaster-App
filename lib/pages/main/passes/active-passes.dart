import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';

import '../../../fragments/pass/pass-list.dart';
import '../../../api/pass_list.dart';
import '../../../models/pass.dart';
import '../../../models/currentuser.dart';
import './view-pass.dart';

class ActivePasses extends StatefulWidget {
  CurrentUserModel user;

  ActivePasses(this.user);

  @override
  ActivePassesState createState() => new ActivePassesState(user);

}

class ActivePassesState extends State<ActivePasses> {
  CurrentUserModel user;
  PassList list;

  ActivePassesState(this.user);

  @override 
  void initState() {
    list = new PassList(null, user);
    getData();
  }

  Future<void> getData() async {
    Iterable<PassModel> passes = await PassListAPI().getData(user.token, "active");
    list.update(passes);
  }

  @override
  Widget build(BuildContext context) {
    return list;
  }
}





