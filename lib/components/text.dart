import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:psychesail/model/time.dart';
import 'package:random_avatar/random_avatar.dart';
import './button.dart';
import 'package:animations/animations.dart';

Widget HigthlightText(fontsize, minheight, txt) {
  return Container(
    constraints: BoxConstraints(
      minHeight: minheight,
    ),
    alignment: Alignment.center,
    child: Center(
      child: Text(
        txt,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: fontsize,
            fontFamily: 'ABeeZee',
            color: Colors.white.withOpacity(0.6),
            fontStyle: FontStyle.italic),
        overflow: TextOverflow.fade,
      ),
    ),
  );
}

Widget greyText(fontsize, minheight, txt) {
  return Center(
    child: Text(
      txt,
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: fontsize,
          fontFamily: 'ABeeZee',
          color: Colors.grey,
          fontStyle: FontStyle.italic),
      overflow: TextOverflow.fade,
    ),
  );
}

Widget divider(constr, greaterwidth, lesswidth, col) {
  return Row(children: [
    Expanded(
      child: new Container(
          margin: EdgeInsets.symmetric(
              horizontal: constr ? greaterwidth : lesswidth),
          child: Divider(
            color: col,
            height: 36,
            thickness: 0.25,
          )),
    ),
    Text("OR",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: col,
          fontSize: 14,
          fontStyle: FontStyle.italic,
          fontFamily: 'ABeeZee',
          fontWeight: FontWeight.w400,
        )),
    Expanded(
      child: new Container(
          margin: EdgeInsets.symmetric(
              horizontal: constr ? greaterwidth : lesswidth),
          child: Divider(
            color: col,
            height: 36,
            thickness: 0.25,
          )),
    ),
  ]);
}

Widget dividervertical(constr, greaterwidth, lesswidth, col) {
  return Column(
    children: [
      Container(
        margin: EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          color: Colors.grey,
          height: greaterwidth,
          width: 1,
        ),
      ),
      Text("OR",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: col,
            fontSize: 14,
            fontStyle: FontStyle.italic,
            fontFamily: 'ABeeZee',
            fontWeight: FontWeight.w400,
          )),
      Container(
        margin: EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          color: Colors.grey,
          height: greaterwidth,
          width: 1,
        ),
      ),
    ],
  );
}

InputDecoration logininput(txt, example) {
  return InputDecoration(
      border: UnderlineInputBorder(),
      labelText: txt,
      labelStyle: TextStyle(
          fontStyle: FontStyle.italic,
          fontFamily: 'ABeeZee',
          fontWeight: FontWeight.w400,
          color: Color.fromRGBO(35, 154, 139, 75)),
      helperText: example);
}

Widget textbubble(
    message, timestamp, receiverid, currentid, bgcolor, condition, context) {
  bool constr = (receiverid == currentid);
  final size = MediaQuery.of(context).size;
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      mainAxisAlignment:
          (constr) ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment:
          (constr) ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Container(
            child: Padding(
          padding: EdgeInsets.all(9.0),
          child: (constr)
              ? Container()
              : RandomAvatar(receiverid,
                  trBackground: false, height: 50, width: 50),
        )),
        Flexible(
          child: Container(
            padding: EdgeInsets.all(11),
            decoration: BoxDecoration(
              color: bgcolor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment:
                  (constr) ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Text(
                  message,
                  style: TextStyle(
                      color: (constr) ? Colors.white : Colors.black,
                      fontSize: 17),
                ),
                SizedBox(height: 4),
                Text(
                  timestamp,
                  style: TextStyle(color: Colors.black45, fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget homechatbubble(
    constr, sizeWidth, sizeHeight, user, context, currentUserId) {
  return Column(children: [
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              print(user['id']);
              print(user['email']);
              print(currentUserId);
              if (user['id'].toString() == "monkeybot") {
                Navigator.pushNamed(context, '/monkeybot', arguments: {
                  'receiveremail': user['email'],
                  'receiverid': user['id'],
                  'currentid': currentUserId,
                });
              } else {
                Navigator.pushNamed(context, '/chatroom', arguments: {
                  'receiveremail': user['email'],
                  'receiverid': user['id'],
                  'currentid': currentUserId,
                });
              }
            },
            child: Text(
              user['id'],
              style: TextStyle(
                color: Colors.black,
                fontSize: constr ? sizeWidth / 40 : sizeWidth / 20,
                fontStyle: FontStyle.italic,
                fontFamily: 'ABeeZee',
              ),
            ),
          )
        ],
      ),
    ),
  ]);
}

Widget settingsContainer(constr, rad, sizeWidth, iconUsed, heading, hint) {
  return Padding(
    padding: EdgeInsets.all(16.0),
    child: Row(
      // mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          width: sizeWidth / 4,
          child: CircleAvatar(
              radius: rad,
              backgroundColor: Colors.grey,
              child: Icon(
                iconUsed,
                size: 25,
                color: Colors.black,
              )),
        ),
        SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                heading,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: constr ? sizeWidth / 40 : sizeWidth / 20,
                  fontStyle: FontStyle.italic,
                  fontFamily: 'ABeeZee',
                ),
              ),
              Text(
                hint,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: constr ? sizeWidth / 40 : sizeWidth / 20,
                  fontStyle: FontStyle.italic,
                  fontFamily: 'ABeeZee',
                ),
              )
            ],
          ),
        )
      ],
    ),
  );
}

Widget _maptextbubble(size) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Container(
        //     child: Padding(
        //   padding: EdgeInsets.all(9.0),
        //   child: RandomAvatar("Serenity",
        //       trBackground: false, height: 50, width: 50),
        // )),
        Flexible(
          child: Container(
            padding: EdgeInsets.all(11),
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  constraints: BoxConstraints(
                      minHeight: size.height / 3, minWidth: size.width / 4),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage("assets/maps_image.png"),
                    fit: BoxFit.cover,
                  )),
                ),
                // Text(
                //   message,
                //   style: TextStyle(
                //       color: Colors.black,
                //       fontSize: 17),
                // ),
                // SizedBox(height: 4),
                Text(
                  "https://maps.app.goo.gl/smBnLVPhTkBku2uk8",
                  style: TextStyle(color: Colors.black, fontSize: 17),
                )
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget communityContainer(
    sizeWidth, sizeHeight, constr, heading, description, imagestring) {
  return Container(
    constraints: BoxConstraints(maxWidth: sizeWidth * 0.8),
    decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.shade300,
        ),
        borderRadius: BorderRadius.all(Radius.circular(8.0))),
    child: Padding(
      padding: EdgeInsets.all(sizeHeight * sizeWidth * 0.00004),
      child: Column(
        children: [
          circleButton(constr, sizeWidth / 100, sizeWidth / 50, imagestring),
          Text(
            heading,
            style: TextStyle(
                color: Colors.black,
                fontSize: sizeWidth * sizeHeight * 0.00008,
                fontWeight: FontWeight.bold),
          ),
          Text(
            description,
            style: TextStyle(
              color: Colors.black,
              fontSize: sizeWidth * sizeHeight * 0.00004,
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    ),
  );
}

Widget historyContainer(
    sizeWidth, sizeHeight, constr, date, time, stressEmoji) {
  return Container(
    constraints: BoxConstraints(minWidth: sizeWidth * 0.7),
    decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.shade300,
        ),
        borderRadius: BorderRadius.all(Radius.circular(8.0))),
    child: Padding(
      padding: EdgeInsets.all(sizeHeight * sizeWidth * 0.00005),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.calendar_month_rounded,
                  color: Color.fromRGBO(35, 154, 139, 75)),
              SizedBox(width: sizeWidth * 0.02),
              Text(
                date,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: sizeWidth * sizeHeight * 0.000055,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
          SizedBox(height: sizeHeight * 0.01),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.schedule, color: Color.fromRGBO(35, 154, 139, 75)),
              SizedBox(width: sizeWidth * 0.02),
              Text(
                time,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: sizeWidth * sizeHeight * 0.000055,
                ),
              )
            ],
          ),
          SizedBox(height: sizeHeight * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: sizeWidth * 0.15),
              Text(
                "Summary of last chat",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: sizeWidth * sizeHeight * 0.000055,
                ),
              ),
              SizedBox(width: sizeWidth * 0.15),
            ],
          ),
          SizedBox(height: sizeHeight * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: sizeWidth * 0.6),
              Text(
                "More",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: sizeWidth * sizeHeight * 0.00005,
                    fontWeight: FontWeight.bold),
              ),
              Icon(Icons.arrow_forward_rounded,
                  color: Colors.black, size: sizeWidth * sizeHeight * 0.00005)
            ],
          )
        ],
      ),
    ),
  );
}

Widget activityContainer(context, sizeWidth, sizeHeight, constr, heading,
    imagestring, pos, currentUserId) {
  print(pos);
  var response;
  return GestureDetector(
    onTap: () async {
      List<String> places = ["hospital"];
      if (heading == "Movies") {
        places = ["movie_theater"];
      }
      if (heading == "Games") {
        places = ["amusement_park", "amusement_center"];
      }
      if (heading == "Cafe") {
        places = ["cafe", "restaurant"];
      }
      // print(hello)
      response = await searchNearbyPlaces(places, pos);
      // print("take me to hell");
      print(response);
      Navigator.pushNamed(context, '/activity-maps', arguments: {
        'places': response,
        'imagestring': imagestring,
        'currentUserId': currentUserId
      });
    },
    child: Container(
      constraints: BoxConstraints(maxWidth: sizeWidth * 0.5),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8.0))),
      child: Padding(
        padding: EdgeInsets.all(sizeHeight * sizeWidth * 0.00005),
        child: Column(
          children: [
            circleButton(constr, sizeWidth / 120, sizeWidth / 100, imagestring),
            Text(
              heading,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: sizeWidth * sizeHeight * 0.00005,
                  fontWeight: FontWeight.bold),
            ),
            // activitymaps(sizeWidth, sizeHeight,constr, response, imagestring,currentUserId),
          ],
        ),
      ),
    ),
  );
}

dynamic searchNearbyPlaces(List<String> places_type, pos) async {
  var responseData;
  print(pos);
  // Define the request body as a JSON object
  var requestBody = {
    "includedTypes": places_type,
    "maxResultCount": 5,
    "locationRestriction": {
      "circle": {
        "center": {"latitude": pos[1], "longitude": pos[0]},
        "radius": 2000.0
      }
    }
  };
  print("hellooo");
  // Encode the request body to JSON
  var requestBodyJson = jsonEncode(requestBody);
  print("hiii");
  // Define the headers
  var headers = {
    'Content-Type': 'application/json',
    'X-Goog-Api-Key':
        'AIzaSyC1ksDmMNde1jArPaZF1VK-Xad2yFyjjHk', // Replace 'YOUR_API_KEY' with your actual API key
    'X-Goog-FieldMask': 'places.displayName,places.googleMapsUri'
  };
// print("hell");
  try {
    // Make the HTTP POST request
    var response = await http.post(
      Uri.parse('https://places.googleapis.com/v1/places:searchNearby'),
      headers: headers,
      body: requestBodyJson,
    );

    // Check if the request was successful (status code 200)
    if (response.statusCode == 200) {
      // Parse the response body (assuming it's JSON) into a Map
      responseData = jsonDecode(response.body);
      // Process the responseData here
      print(responseData);

      // return responseData;
    } else {
      // Request was not successful
      print('Request failed with status: ${response.statusCode}');
      print('Response body: ${response.body}');
      responseData = jsonDecode(response.body);
    }
  } catch (e) {
    // Handle any errors that occurred during the HTTP request
    print('Error occurred: $e');
  }
  return responseData;
}
