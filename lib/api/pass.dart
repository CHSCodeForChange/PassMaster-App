import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import './api.dart';
import '../models/pass.dart';
import '../models/srt-pass.dart';
import '../models/location-pass.dart';
import '../models/teacher-pass.dart';

class PassAPI extends API {
  Future<PassModel> getData(String token, int pk, String type, String action) async {
    String url = this.baseUrl + 'passes/' + pk.toString() + '/?format=json';
    
    if (type != null) {
      url += '&type=' + type;
    }

    if (action != null) {
      url += '&action=' + action;
    }

    var response = await http.get(
      Uri.encodeFull(url),
      headers: {
        "Authorization": token, 
      }
    );

    print(response.body);

    PassModel pass;
    Map<String, dynamic> data = json.decode(response.body);

    if (type != null) {
      if (type == "TeacherPass") {
        pass = new TeacherPassModel.fromJson(data);
      } else if (type == "SRTPass") {
        pass = new SRTPassModel.fromJson(data);
      } else if (type == "LocationPass") {
        pass = new LocationPassModel.fromJson(data);
      }
    } else {
      print("THIS WAS NOT A VALID TYPE");
      pass = new PassModel.fromJson(data);
    }


    return pass;
  }
}
