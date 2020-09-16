import 'package:drarogyam/models/user.dart';
import 'package:drarogyam/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //user obj from firebase
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  //auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  //sign in  anon
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in email and passwd
  Future signInWithEmailAndPassword(String email, String passwd) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: passwd);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //register with email and password
  Future registerWithEmailandPassword(String email, String passwd, String name,
      String age, String score, String flag, String lat, String long) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: passwd);
      FirebaseUser user = result.user;
      await DatabaseService(uid: user.uid)
          .updateUserData(name, age, score, flag, lat, long);
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //logout
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
