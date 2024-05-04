import 'package:google_books_api/google_books_api.dart';

Future<dynamic>  buildAPI() async{
  var google = await GoogleBooksApi().searchBooks(
    'book',
    maxResults: 20,
    printType: PrintType.books,
    orderBy: OrderBy.relevance,
    queryType: QueryType.subject,
);

}