import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import './api.dart';
import './user.dart';
import '../models/user.dart';
import '../models/currentuser.dart';

class LoginAPI extends API {
  Future<UserModel> getData(String username, String password) async {
    String url = this.baseUrl + 'login/?format=json';
    var response = await http.post(
      Uri.encodeFull(url),
      body: {
        "username": username, 
        "password": password,
      }
    );

    if (json.decode(response.body)['non_field_errors'] != null) {
      throw(json.decode(response.body)['non_field_errors'][0]);
    }
    
    String token = "Token " + json.decode(response.body)['token'];
    
    UserModel user = await UserAPI().getData(token, null);
    return CurrentUserModel.fromUser(user, token);
  }
}
