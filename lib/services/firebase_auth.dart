import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseAuthenatication {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> login(String email, String password) async {
    try {
      _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      var res = (e.toString());
      debugPrint(res);
    }
  }

  Future<void> register(String email, String password) async {
    try {
      _auth.createUserWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      var res = (e.toString());
      debugPrint(res);
    }
  }

  Future<void> logout() async {
    try {
      _auth.signOut();
    } catch (e) {
      var res = (e.toString());
      debugPrint(res);
    }
  }
}
