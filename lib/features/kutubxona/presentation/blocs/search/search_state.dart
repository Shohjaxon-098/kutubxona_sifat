import 'package:kutubxona/features/kutubxona/domain/entities/book_entity.dart';


abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<BookEntity> books;

  SearchLoaded(this.books);
}

class SearchError extends SearchState {
  final String message;

  SearchError(this.message);
}
