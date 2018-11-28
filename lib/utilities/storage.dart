
import 'package:shared_preferences/shared_preferences.dart';
import '../models/currentuser.dart';

class Storage {

  Future<SharedPreferences> getPrefs() async {
    return await SharedPreferences.getInstance();
  }

  void storeUser(CurrentUserModel user) async {
    final prefs = await getPrefs();
    prefs.setString("token", user.token);
    prefs.setInt("pk", user.pk);
    prefs.setString("username", user.username);
    prefs.setString("firstname", user.firstname);
    prefs.setString("lastname", user.lastname);
    prefs.setString("email", user.email);
    prefs.setString("type", user.type);
  }

  Future<CurrentUserModel> getUser() async {
    final prefs = await getPrefs();
    String token = prefs.getString("token");
    int pk = prefs.getInt("pk");
    String username = prefs.getString("username");
    String firstname = prefs.getString("firstname");
    String lastname = prefs.getString("lastname");
    String email = prefs.getString("email");
    String type = prefs.getString("type");

    if (token == null) return null;
    return new CurrentUserModel(pk, username, firstname, lastname, email, type, token);
  }

  void removeUser() async {
    final prefs = await getPrefs();
    prefs.remove("token");
    prefs.remove("pk");
    prefs.remove("username");
    prefs.remove("firstname");
    prefs.remove("lastname");
    prefs.remove("email");
    prefs.remove("type");
  }
}