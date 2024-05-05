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
YoutubeDataApi youtubeDataApi = YoutubeDataApi();
List videoResult = await youtubeDataApi.fetchSearchVideo('motivation','AIzaSyBVOgf5N_kO5_BdX7lZ-DDCRv7bRzYSOOs');
List<Video> listVideo = [];
videoResult.forEach((element){
    if(element is Video && element.thumbnails != null && element.title!.length <= 50){
      listVideo.add(element);
    } 
});
return [filteredList,listVideo];
}