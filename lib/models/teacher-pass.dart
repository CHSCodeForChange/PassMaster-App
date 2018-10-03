import './user.dart';
import './pass.dart';


class TeacherPassModel extends PassModel {
  UserModel destinationTeacher;

  TeacherPassModel(
    int pk, 
    bool approved,
    DateTime date, 
    Duration startTimeRequested, 
    Duration endTimeRequested, 
    UserModel student, 
    UserModel originTeacher,
    String description, 
    String type,
    UserModel destinationTeacher
  ) 
  :super(pk, approved,
    date, startTimeRequested, endTimeRequested, null,null,
    student, originTeacher,
    description, "LocationPass", destinationTeacher.getName()) {
      this.destinationTeacher = destinationTeacher;
  }

  TeacherPassModel.fromJson(Map<String, dynamic> json) :super.fromJson(json) {
    this.destinationTeacher = UserModel.fromSubJson(json['destinationTeacher']);
  }
}