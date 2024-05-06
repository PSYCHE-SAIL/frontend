import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:google_books_api/google_books_api.dart';
import 'package:youtube_data_api/models/video.dart';
import 'package:youtube_data_api/youtube_data_api.dart';

Future<dynamic>  buildAPI() async{
  var google = await GoogleBooksApi().searchBooks(
    'motivation',
    maxResults: 40,
    printType: PrintType.books,
    orderBy: OrderBy.relevance,
    queryType: QueryType.subject,
);
List<Book> filteredList = google.where((item) =>
  item.volumeInfo.description.isNotEmpty &&
  item.volumeInfo.description.length <= 214 &&
  item.volumeInfo.imageLinks != null &&
  item.volumeInfo.title.length <= 20
).toList();
if(filteredList.length == 0) print("null");
YoutubeDataApi youtubeDataApi = YoutubeDataApi();
List videoResult = await youtubeDataApi.fetchSearchVideo('motivation','AIzaSyBVOgf5N_kO5_BdX7lZ-DDCRv7bRzYSOOs');
List<Video> listVideo = [];
videoResult.forEach((element){
    if(element is Video && element.thumbnails != null && element.title != null && element.title!.length <= 70){
      listVideo.add(element);
    } 
});

if(listVideo.length == 0) print("null");
return [filteredList,listVideo];
}

Future<void> fetchChatId(userinputs) async {
      var url = Uri.parse('http://192.168.197.137:8000/getChatRoomID');
      try {
        print("Sending request...");
        print(jsonEncode({"inputs": userinputs}));
        var response = await http.post(
          url,
          headers: {
            "content-type": "application/json",
            "Access-Control-Allow-Origin":
                "*", // Required for CORS support to work
            "Access-Control-Allow-Credentials":
                'true', // Required for cookies, authorization headers with HTTPS
            "Access-Control-Allow-Headers":
                "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
            "Access-Control-Allow-Methods": "GET, POST,OPTIONS"
          },
          body: jsonEncode({"inputs": userinputs}),
        );
        if (response.statusCode == 200) {
          print("Data sent successfully");
          print("Response from server: ${response.body}");

          return jsonDecode(response.body);
        } else {
          print("Failed to send data. Status code: ${response.statusCode}");
          print("Response body: ${response.body}");
        }
      } catch (e) {
        print("Error sending data: $e");
      }
    }