import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class SearchPlacesScreen extends StatelessWidget {
   SearchPlacesScreen({super.key});

  List<String> places = [];
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args =
    ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    Position pos = args?['pos'];
    places = args?['place'];
    return Scaffold(
        appBar: AppBar(
          title: const Text("Google Search Places"),
        ),
        body: ElevatedButton(onPressed:() { searchNearbyPlaces(places,pos); }, child: const Text("Search Places"))
    );
  }
}

void searchNearbyPlaces(List<String> places_type, Position pos) async {
    // Define the request body as a JSON object
    var requestBody = {
      "includedTypes": ["amusement_park"],
      "maxResultCount": 5,
      "locationRestriction": {
        "circle": {
          "center": {
            "latitude": pos.latitude,
            "longitude": pos.longitude
          },
          "radius": 2000.0
        }
      }
    };

    // Encode the request body to JSON
    var requestBodyJson = jsonEncode(requestBody);

    // Define the headers
    var headers = {
      'Content-Type': 'application/json',
      'X-Goog-Api-Key': 'AIzaSyC1ksDmMNde1jArPaZF1VK-Xad2yFyjjHk', // Replace 'YOUR_API_KEY' with your actual API key
      'X-Goog-FieldMask': 'places.displayName,places.googleMapsUri'
    };

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
        var responseData = jsonDecode(response.body);
        // Process the responseData here
        print(responseData);
      } else {
        // Request was not successful
        print('Request failed with status: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      // Handle any errors that occurred during the HTTP request
      print('Error occurred: $e');
    }
  }

// AIzaSyC1ksDmMNde1jArPaZF1VK-Xad2yFyjjHk