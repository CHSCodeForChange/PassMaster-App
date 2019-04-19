class TempModel {
  DateTime dateTime;
  double temp;

  TempModel.fromJson(Map<String, dynamic> json) {
    dateTime = DateTime.parse(json['datetime']);
    temp = json['temp'];
  }
}