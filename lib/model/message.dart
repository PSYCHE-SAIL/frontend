import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderid;
  final String senderEmail;
  final String receiverid;
  final String message;
  final Timestamp timestamp;

  Message({
  required this.senderid,
  required this.senderEmail,
  required this.receiverid,
  required this.message,
  required this.timestamp
});


  Map<String, dynamic> toMap() {
    return {
      'senderid' : senderid,
    'senderEmail':senderEmail,
    'receiverid':receiverid,
    'message':message,
    'timestamp':timestamp,
    };
  }
}