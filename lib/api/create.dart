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
    
    if (type=="LocationPass") {
      data = (pass as LocationPassModel).toJson();
    } else if (type == "TeacherPass") {
      data = (pass as TeacherPassModel).toJson();
    } else if (type == "SRTPass") {
      data = (pass as SRTPassModel).toJson();
    }

    url += type;

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
