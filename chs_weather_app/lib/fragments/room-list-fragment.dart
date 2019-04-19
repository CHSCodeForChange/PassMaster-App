import 'package:flutter/material.dart';

class RoomListFrag extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "96",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 40.0,
            ),
          ),
          Text(
            "E117",
            textAlign: TextAlign.right,
          )
        ],
      ),
    );
  }

}