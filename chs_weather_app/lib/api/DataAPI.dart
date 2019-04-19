import 'package:chs_weather_app/models/room-model.dart';
import 'package:http/http.dart' as http;


class DataAPI {
  static Uri listURI = Uri.http("chsweather.herokuapp.com", "/rest/rooms/");

  static Future<List<RoomModel>> getRoomList() async {
    var response = await http.get(
      listURI
    );
    print(response.body);
  }
}