import 'package:chs_weather_app/models/temp-model.dart';

class RoomModel {
  String name;
  String department;
  TempModel temp;

  RoomModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    department = json['department'];
    temp = new TempModel.fromJson(json['temp']);
  }
}