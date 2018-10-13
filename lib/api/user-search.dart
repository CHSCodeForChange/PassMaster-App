import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import './api.dart';
import '../models/user.dart';

class UserListAPI extends API {
  Future<Iterable<UserModel>> getData(String token, String type, String username) async {
    String url = this.baseUrl + 'users/?format=json';

    if (type != null) {
      if (type == '1') {
        url = this.baseUrl + 'students/?format=json';
      } else if (type == '2') {
        url = this.baseUrl + 'teachers/?format=json';
      }
    }
    
    if (username != null) {
      url += '&username=' + username;
    }

    var response = await http.get(
      Uri.encodeFull(url),
      headers: {
        "Authorization": token, 
      }
    );

    List rawPasses = json.decode(response.body);
    Iterable<UserModel> users = (rawPasses).map((i) => new UserModel.fromJson(i));

    return users;
  }
}
