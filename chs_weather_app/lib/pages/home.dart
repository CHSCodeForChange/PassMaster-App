import 'package:chs_weather_app/api/DataAPI.dart';
import 'package:chs_weather_app/fragments/room-list-fragment.dart';
import 'package:chs_weather_app/models/room-model.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<RoomModel> rooms = [];

  @override
  void initState() {
    super.initState();
  }

  Future<ListView> getRooms() async {
    List<RoomModel> roomlist = await DataAPI.getRoomList();
    setState(() {
      rooms = roomlist;
    });
    return ListView.builder(itemBuilder: (context, index) {
      return RoomListFrag();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("CHS Weather"),),
      body: FutureBuilder<ListView> (
        future: getRooms(),
        builder: (context, snapshot) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return RoomListFrag();
            },
          );
        },
      ),
    );
  }
}
