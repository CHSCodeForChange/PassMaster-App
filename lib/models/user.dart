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

  UserModel.fromJson(Map<String, dynamic> json){
    if (json == null) {
      return;
    }
    if (json['pk'] is int) {
      pk = json['pk'];
    }
    else if (json['pk'] is String) {
      try {
        pk = int.parse(json['pk']);
      } catch (e) {
        print(e.toString());
      }
    }
    username = json['username'];
    firstname = json['first_name']; 
    lastname = json['last_name'];
    email = json['email'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() => {
    "pk": pk.toString(),
    "username": username,
    "first_name": firstname,
    "last_name": lastname,
    "email": email,
    "type": type
  };
  
  bool isSame(UserModel user) {
    return this.pk == user.pk;
  }

  bool isStudent() {
    return type == "1";
  }

  bool isTeacher() {
    return type == "2";
  }

  bool isAdministrator() {
    return type == "3";
  }

  bool isLocation() {
    return type == "4";
  }
}