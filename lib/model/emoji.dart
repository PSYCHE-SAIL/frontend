import 'package:flutter/material.dart';

class Emoji {
   Map<String,List<dynamic>> _stressToEmoji = {
   '1' : ['assets/stress_1.png','Bouncing with joy today!',Colors.green],
   '2' : ['assets/stress_2.png','Taking it easy and breezy.',Colors.lime],
   '3' : ['assets/stress_3.png','Keeping it together.',Colors.yellow],
   '4' : ['assets/stress_4.png','Feeling the tension creep in.',Colors.orange],
   '5' : ['assets/stress_5.png','Whirlpool of stress!',Colors.red]
  };
  Emoji() ;



  List<dynamic> stressEmoji(String stress) {
    return _stressToEmoji[stress] ?? ['assets/stress_5.png','Therapist needed',Colors.red];
  }
}