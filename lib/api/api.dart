import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

abstract class API {
  //change to false for debug mode.
  String baseUrl = true ? "https://passmaster.herokuapp.com/rest/" : "http://127.0.0.1:8000/rest/";
}
