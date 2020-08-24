import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart';

class Authentication {
  FirebaseAuth auth = FirebaseAuth.instance;

  currentUser() async {
    try {
      await Future.delayed(Duration(milliseconds: 500));
      User user = auth.currentUser;
      String email = user.email;
      return email;
    } catch (e) {
      return "";
    }
  }

  dynamic register(email, name, pass) async {
    try {
      await auth.createUserWithEmailAndPassword(email: email, password: pass);
      Response res = await get(
          "http://khaled.3dbeirut.com/Textbooks%20App/Scripts/Insert%20User.php?email=$email&name=$name");
      print(res.body);
      if (res.body == "[SUCCESS]")
        return "[SUCCESS]";
      else
        return "[FAIL]";
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> signIn(email, pass) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: pass);
      return "[SUCCESS]";
    } catch (e) {
      return e;
    }
  }

  dynamic anonymousSignIn() async {
    try {
      await auth.signInAnonymously();
      return true;
    } catch (e) {
      return false;
    }
  }

  signOut() async {
    await auth.signOut();
  }
}
