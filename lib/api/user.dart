import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import './api.dart';
import '../models/user.dart';

class UserAPI extends API {
  Future<UserModel> getData(String token, int user) async {
    String url = this.baseUrl + 'user/?format=json';

    if (user != null) {
      url += '&user=' + user.toString();
    }
    var response = await http.get(
      Uri.encodeFull(url),
      headers: {
        "Authorization": token, 
      }
    );

    return UserModel.fromJson(json.decode(response.body));
  }
}
