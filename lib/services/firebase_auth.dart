import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthenatication {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> login(String email, String password) async {
    try {
      _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> register(String email, String password) async {
    try {
      _auth.createUserWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> logout() async {
    try {
      _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
