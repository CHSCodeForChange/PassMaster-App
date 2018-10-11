import './user.dart';
import './pass.dart';

class LocationPassModel extends PassModel {
  String location;

  LocationPassModel(
    DateTime date,
    Duration startTimeRequested,
    Duration endTimeRequested,
    UserModel student, 
    UserModel originTeacher,
    String description, 
    String location
  ) 
  :super(date, startTimeRequested, endTimeRequested,
    student, originTeacher,
    description, "LocationPass", location) {
      this.location = location;
  }

  LocationPassModel.fromJson(Map<String, dynamic> json) :super.fromJson(json) {
    this.location = json['location'];
  }

  Map<String, dynamic> toJson() =>
    {
      'date' : date, 
      'student' : student.pk, 
      'originTeacher' : originTeacher.pk,
      'description' : description, 
      'location' : location,
      'startTimeRequested': startTimeRequested,
      'endTimeRequested': endTimeRequested,
    };
}