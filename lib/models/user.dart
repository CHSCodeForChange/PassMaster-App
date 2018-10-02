class UserModel {
  int pk;
  String username;
  String firstname;
  String lastname;
  String email;
  String type;

  UserModel(this.pk, this.username, this.firstname, this.lastname, this.email, this.type);

  static UserModel testModel() {
    return UserModel(0, 'username', 'First', 'Last', 'first.last@gmail.com', '1');
  }

  String getName() {
    return this.firstname + " " + this.lastname;
  }

  UserModel.fromJson(Map<String, dynamic> json): 
    pk = json['pk'],
    username = json['username'],
    firstname = json['first_name'], 
    lastname = json['last_name'],
    email = json['email'],
    type = json['type'];

  bool isSame(UserModel user) {
    return this.pk == user.pk;
  }
}