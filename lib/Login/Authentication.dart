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
      UserCredential user = await auth.createUserWithEmailAndPassword(email: email, password: pass);
      Response res = await get(
          "http://khaled.3dbeirut.com/Textbooks%20App/Scripts/Insert%20User.php?email=$email&name=$name");
      if (res.body == "[SUCCESS]")
        return "[USER]" + user.user.email;
      else
        return "An unknown error has occurred.";
    } catch (e) {
      switch(e.code){
        case "invalid-email":
          return "Enter a proper email address";
        case "email-already-exists":
          return "An account already exists with this email";
      }
      return e.toString();
    }
  }

  Future<dynamic> signIn(email, pass) async {
    try {
      UserCredential user = await auth.signInWithEmailAndPassword(email: email, password: pass);
      return "[USER]" + user.user.email;
    } catch (e) {
      print(e.code);
      switch (e.code) {
        case "wrong-password":
          return "Enter a valid password";
        case "user-not-found":
          return "No account exists with this email.";
        case "invalid-email":
          return "Email address is badly formatted.";
      }
      return e.message;
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
