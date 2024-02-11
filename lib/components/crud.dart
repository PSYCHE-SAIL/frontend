import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

dynamic createRecord(name,email,id,password) async {
  DatabaseReference ref = FirebaseDatabase.instance.ref("/users/$id");
  var check = await getData(id);
  if(check == 'No data available.') {
    ref.set({
  "name": name,
  "email": email,
  "password": password
});
return 'created';
  }  else if(check['email'] == email) return 'userExists';
  return {};
}

dynamic getData(id) async {
final reff = FirebaseDatabase.instance.ref();
final snapshot = await reff.child('/users/$id').get();
if (snapshot.exists) {
   return (snapshot.value);
} else {
   return ('No data available.');
}
}

dynamic checkUser(name,email,password) async {
  var check = await getData(name);
  if(check == 'No data available.') return 'IncorrectDetails';
  if(check['name'] == name && check['email'] == email && check['password'] == password) {
    return 'userExists';
  } else return 'IncorrectDetails';
}

