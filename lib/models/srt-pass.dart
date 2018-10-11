import './user.dart';
import './pass.dart';


class SRTPassModel extends PassModel {
  UserModel destinationTeacher;
  String session;

  SRTPassModel(
    DateTime date, 
    UserModel student, 
    UserModel originTeacher,
    String description, 
    UserModel destinationTeacher,
    String session
  ) :super(date, getStart(session), getEnd(session),
    student, originTeacher,
    description, "SRTPass", destinationTeacher.getName()) {
      this.destinationTeacher = destinationTeacher;
      this.session = session;
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

  Map<String, dynamic> toJson() =>
    {
      'date' : getDateJson(), 
      'student' : student.pk, 
      'originTeacher' : originTeacher.toJson(),
      'description' : description, 
      'destinationTeacher' : destinationTeacher.toJson(),
      'session': session
    };

  SRTPassModel.fromJson(Map<String, dynamic> json) :super.fromJson(json) {
    this.destinationTeacher = UserModel.fromJson(json['destinationTeacher']);
  }
}