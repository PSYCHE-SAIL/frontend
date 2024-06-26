import 'package:flutter/material.dart';

class Places extends ChangeNotifier{
  List<String> place = ["hospital"];
  bool val = false;
  bool remove = true;
  Map<dynamic,dynamic> object = {
    "places" : [{
      "googleMapsUri" : "Disha",
      "displayName" : {
        "text" : "fast",
        "languageCode" : "en"
      }
    }]
  };
  String imagestring = "assets/group_dp.png";
  Map<String,List<String>> _placeToFind = {
    "Movies" : ["movie_theater"],
    "Games" : ["amusement_park","amusement_center"],
    "Cafe" : ["cafe","restaurant"]
  };
  Places();

  void setPlace(String place) {
    this.place =  _placeToFind[place] ?? ["hospital"];
  }

  List<String> getPlace() {
    return place;
  }

  void setval() {
    val = true;
  }

  bool getval() {
    return val;
  }

  void setremove(val) {
    remove = val;
  }

  bool getremove() {
    return remove;
  }

  void setImagestring(String url) {
    imagestring = url;
  }

  String getImagestring() {
    return imagestring;
  }

  void setObject(obj) {
    object["places"] = obj["places"];
    notifyListeners();
  }

  dynamic getObject() {
    return object;
  }
}