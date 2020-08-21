import 'package:firebase_auth/firebase_auth.dart';

class Authentication {
  FirebaseAuth auth;

  Authentication(){
    auth = FirebaseAuth.instance;
  }
  currentUser() async {
    try {
      User user = auth.currentUser;
      String email = user.email;
      return email;
    } catch (e) {
      return null;
    }
  }

  dynamic register(email, pass) async {
    try {
      await auth.createUserWithEmailAndPassword(email: email, password: pass);
      return true;
    } catch (e) {
      return false;
    }
  }

  dynamic signIn(email, pass) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: pass);
      return true;
    } catch (e) {
      return false;
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
