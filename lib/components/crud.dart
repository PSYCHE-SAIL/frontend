

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:psychesail/components/text.dart';
import 'package:psychesail/model/message.dart';
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
    createChatrooms(name, "Serenity", "");
    createChatrooms(name, "Groupchat", "");
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
_firestore.collection('chatAvailable').doc('$currentUser').set({
  "$receiveUser" : {'message' : message, 'time' : formattedTime, 'date': formattedDate}
},SetOptions(merge: true));
}

dynamic getUsers(currentuser) async {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  dynamic user = await _firestore.collection('chatAvailable').doc('$currentuser').get();
  print(user.data().values);
  dynamic community = await _firestore.collection('community').get();
  print(community.docs[0]['description']);
  return [user.data(),community.docs];
}

Future<void> sendmessage(String receiverId, String message, currentid) async{
    // get user info
      FirebaseFirestore _firestore = FirebaseFirestore.instance;
    var snap = await getData(currentid);
print(snap['email']);
    print(receiverId);
    // print(receiveremail);
    print(currentid);
    final String currentUserId = currentid;
    final String currentEmailId = snap['email'];
    final timestamp = Timestamp.now();


    // create a new message
    Message newMessage = Message(
    senderEmail: currentEmailId,
    senderid: currentUserId,
    receiverid: receiverId,
    message: message,
    timestamp: timestamp,
    );
    //construct chatroom id for current user id and sender id (sorted to ensure uniqueness)
    List<String> ids = [currentUserId, receiverId];
    ids.sort();
    String chatroomId = ids.join("_");




    //add new message to database
    await _firestore.collection('chat_rooms').doc(chatroomId).collection('messages').add(newMessage.toMap());
  }

  // GET MESSAGES
  Stream<QuerySnapshot> getmessages(String userId, String otheruserId) {
      FirebaseFirestore _firestore = FirebaseFirestore.instance;

    List<String> ids= [userId, otheruserId];
    ids.sort();
    String chatroomid =  ids.join("_");
    return _firestore.collection('chat_rooms').doc(chatroomid).collection('messages').orderBy('timestamp', descending: false).snapshots();
  }

  // COMMUNITY DESCRIPTION RETRIEVE DATA 
  Future<void> sendcommunitymessage(String message, currentid, String title, String subtitle) async{
    // get user info
      FirebaseFirestore _firestore = FirebaseFirestore.instance;
    var snap = await getData(currentid);
print(snap['email']);
    // print(receiveremail);
    print(currentid);
    final String currentUserId = currentid;
    final String currentEmailId = snap['email'];
    final timestamp = Timestamp.now();


    // create a new message
    groupMessage newMessage = groupMessage(
    senderEmail: currentEmailId,
    senderid: currentUserId,
    message: message,
    timestamp: timestamp,
    );



    //add new message to database
    await _firestore.collection('community').doc(title).collection(subtitle).add(newMessage.toMap());
  }

// GET COMMUNITY MESSAGES
  Stream<QuerySnapshot> getcommunitymessages(String userId, String title, String subtitle) {
      FirebaseFirestore _firestore = FirebaseFirestore.instance;
    return _firestore.collection('community').doc(title).collection(subtitle).orderBy('timestamp', descending: false).snapshots();
  }

  // GET COMMUNTIY TITLES 
  Future<QuerySnapshot<Map<String, dynamic>>> getcommunity() async {
      FirebaseFirestore _firestore = FirebaseFirestore.instance;
    return _firestore.collection('community').get();
  }
