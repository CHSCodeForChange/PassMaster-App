import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import './add.dart';
import './home.dart';
import './passes.dart';
import '../../models/currentuser.dart'; 

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
  int index = 1;

  MainState(user) {
    this.user = user;
    if (user.type == '1') {
      pages = [
        new Add(user),
        new Home(user),
        new Passes(user)
      ];

      bar = [
            BottomNavigationBarItem(
              icon: new Icon(Icons.add),
              title: new Text('Add'),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.home),
              title: new Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              title: Text('Passes')
            )
          ];
    } else if (user.type == '2') {
       pages = [
        new Add(user),
        new Home(user),
        new Passes(user)
      ];
      
      bar = [
            BottomNavigationBarItem(
              icon: new Icon(Icons.add),
              title: new Text('Add'),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.home),
              title: new Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              title: Text('Passes')
            )
          ];
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
        primaryColor: Colors.orangeAccent,
        accentColor: Colors.orangeAccent,
      ),
      child: Scaffold(

        bottomNavigationBar: BottomNavigationBar( 
          currentIndex: index, 
          onTap: onTabTapped,
          items: bar,
        ),

        body: pages[index],
      )
    );
  }
}