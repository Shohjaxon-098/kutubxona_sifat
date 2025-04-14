import 'package:kutubxona/features/kutubxona/data/models/book.dart';


abstract class BookSearchState {}

class BookSearchInitial extends BookSearchState {}

class BookSearchLoading extends BookSearchState {}

class BookSearchLoaded extends BookSearchState {
  final List<Book> results;
  BookSearchLoaded(this.results);
}

class BookSearchError extends BookSearchState {
  final String message;
  BookSearchError(this.message);
}
