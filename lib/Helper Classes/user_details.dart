import 'package:http/http.dart';

class UserDetails {
  static String email, name;

  static setUserDetails(String mail) async {
    email = mail;
    if (mail != "anon") {
      Response res = await get(
          "https://textbooks.azurewebsites.net/PHP%20API/Get%20Username%20From%20Email.php?email=$mail");
      name = res.body;
    }
  }

  static delUserDetails() {
    email = null;
  }
}
