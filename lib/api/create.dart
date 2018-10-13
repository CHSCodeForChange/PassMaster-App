import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import './api.dart';
import '../models/srt-pass.dart';
import '../models/location-pass.dart';
import '../models/teacher-pass.dart';
import '../models/pass.dart';

class CreatePassAPI extends API {
  Future<PassModel> getData(String token, PassModel pass) async {
    String url = this.baseUrl + 'passes/create/?format=json&type=';

    Map<dynamic, dynamic> data;
    
    if (pass.type=="LocationPass") {
      data = (pass as LocationPassModel).toJson();
    } else if (pass.type == "TeacherPass") {
      data = (pass as TeacherPassModel).toJson();
    } else if (pass.type == "SRTPass") {
      data = (pass as SRTPassModel).toJson();
    }

    url += pass.type;

    var response = await http.post(
      Uri.encodeFull(url),
      body: data,
      headers: {
        "Authorization": token, 
      }
    );

    if (pass.type=="LocationPass") {
      pass = LocationPassModel.fromJson(json.decode(response.body));
    } else if (pass.type == "TeacherPass") {
      pass = TeacherPassModel.fromJson(json.decode(response.body));
    } else if (pass.type == "SRTPass") {
      pass = SRTPassModel.fromJson(json.decode(response.body));
    }

    return pass;
  }
}
