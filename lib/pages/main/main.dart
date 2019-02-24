import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import './add.dart';
import './home.dart';
import './passes.dart';
import '../../models/currentuser.dart';
import 'package:flutter/services.dart';


class Main extends StatefulWidget {
  CurrentUserModel user;

  Main(this.user);

  @override
  MainState createState() => new MainState(user);

}

class MainState extends State<Main> {
  CurrentUserModel user;
  List pages;
  List<BottomNavigationBarItem> bar;
  int index = 0;

  MainState(user) {
    this.user = user;
    pages = [];
    bar = [];
    if (user.isStudent() || user.isTeacher()) {
      pages.add(Add(user));
      bar.add(
        BottomNavigationBarItem(
          icon: new Icon(Icons.add),
          title: new Text('Add'),
        )
      );
      index = 1;
    }
    if (user.isStudent() || user.isTeacher() || user.isLocation()) {
      pages.addAll([
        new Home(user),
        new Passes(user)
      ]);

      bar.addAll([
        BottomNavigationBarItem(
          icon: new Icon(Icons.home),
          title: new Text('Home'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard),
          title: Text('Passes')
        )
      ]);
    } 
  }

  void onTabTapped(int index) {
    setState(() {
      this.index = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        scaffoldBackgroundColor: Colors.orangeAccent,
      ),
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: index, 
          onTap: onTabTapped,
          items: bar,
          fixedColor: Colors.orangeAccent,
        ),

        body: pages[index],
      )
    );
  }
}