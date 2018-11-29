import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';

import '../../../fragments/pass-list.dart';
import '../../../api/pass_list.dart';
import '../../../models/pass.dart';
import '../../../models/currentuser.dart';

class PendingPasses extends StatefulWidget {
  CurrentUserModel user;

  PendingPasses(this.user);

  @override
  PendingPassesState createState() => new PendingPassesState(user);

}

class PendingPassesState extends State<PendingPasses> {
  CurrentUserModel user;
  PassList list;

  PendingPassesState(this.user);

  @override 
  void initState() {
    list = new PassList(null, user);
    getData();
  }

  Future<void> getData() async {
    Iterable<PassModel> passes = await PassListAPI().getData(user.token, listType: "pending");
    list.update(passes);
  }

  @override
  Widget build(BuildContext context) {
    return list;
  }
}