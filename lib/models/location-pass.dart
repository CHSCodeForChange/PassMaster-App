import './user.dart';
import './pass.dart';

class LocationPassModel extends PassModel {
  String location;

  LocationPassModel(
    int pk, 
    bool approved,
    DateTime date, 
    Duration startTimeRequested, 
    Duration endTimeRequested, 
    UserModel student, 
    UserModel originTeacher,
    String description, 
    String type,
    String location
  ) 
  :super(pk, approved,
    date, startTimeRequested, endTimeRequested, null,null,
    student, originTeacher,
    description, "LocationPass", location) {
      this.location = location;
  }

  LocationPassModel.fromJson(Map<String, dynamic> json) :super.fromJson(json) {
    this.location = json['location'];
  }
}