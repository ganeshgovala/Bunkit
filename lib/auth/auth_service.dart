// ignore_for_file: prefer_final_fields

import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  //instance
  FirebaseAuth _auth = FirebaseAuth.instance;

  //login
  Future<UserCredential> login({required String email,required String password}) async {
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
    return userCredential;
  }

  //register
  Future<UserCredential> register(String email, String password) async {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    return userCredential;
  }

  //logout
}