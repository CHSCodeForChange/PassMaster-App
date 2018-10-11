import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import './api.dart';
import '../models/srt-pass.dart';
import '../models/location-pass.dart';
import '../models/teacher-pass.dart';
import '../models/pass.dart';

class CreatePassAPI extends API {
  Future<Map<String, dynamic>> getData(PassModel pass, String type) async {
    String url = this.baseUrl + 'create/?format=json&type=';

    Map<String, dynamic> data;
    if (type=="LocationPassModel") {
      data = (pass as LocationPassModel).toJson();
      url += 'LocationPass';
    } else if (type == "TeacherPassModel") {
      data = (pass as TeacherPassModel).toJson();
      url += 'TeacherPass';
    } else if (type == "SRTPassModel") {
      data = (pass as SRTPassModel).toJson();
      url += 'SRTPass';
    }

    print(url);
    print(data);

    var response = await http.post(
      Uri.encodeFull(url),
      body: data
    );

    print(response.body);

    if (json.decode(response.body)['non_field_errors'] != null) {
      throw(json.decode(response.body)['non_field_errors'][0]);
    }
    
    return json.decode(response.body);
  }
}
