import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthService extends ChangeNotifier{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // sign user up
  Future<dynamic> signUpWithEmailAndPassword(String email, String password) async{
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);

      return userCredential;
    }
    on FirebaseAuthException catch(e) {
      throw Exception(e.code);
    }
  }

  // sign in user

  Future<dynamic> signInWithEmailAndPassword(String email, String password) async{
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);

      return userCredential;
    }
    on FirebaseAuthException catch(e) {
      throw Exception(e.code);
    }
  }

}