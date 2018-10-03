import './user.dart';
import './pass.dart';


class SRTPassModel extends PassModel {
  UserModel destinationTeacher;
  String session;

  SRTPassModel(
    int pk, 
    bool approved,
    DateTime date, 
    UserModel student, 
    UserModel originTeacher,
    String description, 
    String type,
    UserModel destinationTeacher,
    String session
  ) 
  :super(pk, approved,
    date, getStart(session), getEnd(session), null,null,
    student, originTeacher,
    description, "LocationPass", destinationTeacher.getName()) {
      this.destinationTeacher = destinationTeacher;
  }

  static Duration getStart(String session) {
    switch(session) {
      case "1":
        return Duration(hours: 9, minutes: 30);
      case "2":
        return Duration(hours: 10, minutes: 20);
      case "3":
        return Duration(hours: 9, minutes: 30);
    }
  }

  static Duration getEnd(String session) {
    switch(session) {
      case "1":
        return Duration(hours: 10, minutes: 20);
      case "2":
        return Duration(hours: 11, minutes: 3);
      case "3":
        return Duration(hours: 11, minutes: 3);
    }
  }

  SRTPassModel.fromJson(Map<String, dynamic> json) :super.fromJson(json) {
    this.destinationTeacher = UserModel.fromSubJson(json['destinationTeacher']);
  }
}