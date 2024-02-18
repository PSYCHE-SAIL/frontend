import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:psychesail/model/userList.dart';


final dateFormatter = DateFormat('yyyy-MM-dd');

final timeFormatter = DateFormat('HH:mm:ss');
dynamic createRecord(name,email,id,password) async {
  FirebaseAuth _auth = FirebaseAuth.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref("/users/$id");
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var check = await getData(id);
  if(check == 'No data available.') {
    ref.set({
      "name": name,
      "email": email,
      "password": password
    });

    _firestore.collection('customers').doc(id).set({
      'id' : id,
      'email' : email,
      'password': password
    });
    createChatrooms(name, "monkeyBot", "");
    return 'created';
  }  else if(check['email'] == email) return 'userExists';
  return {};
}

dynamic getData(id) async {
  final reff = FirebaseDatabase.instance.ref();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final snapshot = await _firestore.collection('customers').doc(id).get();
  if (snapshot.exists) {
    return (snapshot);
  } else {
    return ('No data available.');
  }
}

dynamic checkUser(name,email,password) async {
  var check = await getData(name);
  if(check == 'No data available.') return 'IncorrectDetails';
  if(check['id'] == name && check['email'] == email && check['password'] == password) {
    return 'userExists';
  } else return 'IncorrectDetails';
}

dynamic createChatrooms(String currentUser,String receiveUser,message) {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String small = "";
  String large = "";
  print(currentUser.runtimeType);
  if(currentUser.compareTo(receiveUser) == -1) {small = currentUser; large = receiveUser;}
  else {large = currentUser; small = receiveUser;}
  final DateTime now = DateTime.now();
final formattedDate = dateFormatter.format(now);
final formattedTime = timeFormatter.format(now);
_firestore.collection('chatAvailable').doc('$currentUser').set({
  "$receiveUser" : {'message' : message, 'time' : formattedTime, 'date': formattedDate}
},SetOptions(merge: true));
  _firestore.collection('chatrooms').doc('${small}_$large').collection('$formattedDate').doc("$currentUser").set({
      "$formattedTime" : message
    
  },SetOptions(merge: true)).then((res) {
     print("created");
  });
}

dynamic updateChat(currentUser,receiveUser,message) {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final DateTime now = DateTime.now();
final formattedDate = dateFormatter.format(now);
final formattedTime = timeFormatter.format(now);
String small = "";
  String large = "";
  if(currentUser < receiveUser) {small = currentUser; large = receiveUser;}
  else {large = currentUser; small = receiveUser;}
_firestore.collection('chatrooms/$small&&$large').doc('$formattedDate').set({
    "$currentUser" : {
      "$formattedTime" : message
    }
  },SetOptions(merge: true)).then((res) {
     print("created");
  });
}

dynamic getUsers(currentuser) async {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  dynamic data = await _firestore.collection('chatAvailable').doc('$currentuser').get();
  print(data.data().values);
  return data.data();
}

