import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../model/message.dart';

class ChatService extends ChangeNotifier{
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref("/users");

  // SEND MESSAGE

}