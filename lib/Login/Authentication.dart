import 'package:firebase_auth/firebase_auth.dart';

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

  dynamic register(email, pass) async {
    try {
      await auth.createUserWithEmailAndPassword(email: email, password: pass);
      return "yes";
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> signIn(email, pass) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: pass);
      return "yes";
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
