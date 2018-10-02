import './user.dart';

class CurrentUserModel extends UserModel {
  String token;

  @override
  CurrentUserModel(int pk, String username, String firstname, String lastname, String email, String type, String token) :super(pk, username, firstname, lastname, email, type) {
    this.token = token;
  }

  CurrentUserModel.fromUser(UserModel user, String token) :super(user.pk, user.username, user.firstname, user.lastname, user.email, user.type) {
    this.token = token;
  }

  CurrentUserModel.fromJson(Map<String, dynamic> json, String token) :super.fromJson(json) {
    this.token = token;
  }


}