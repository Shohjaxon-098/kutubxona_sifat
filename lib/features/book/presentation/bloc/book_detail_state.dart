import 'package:kutubxona/features/book/domain/entities/book_detail.dart';


abstract class BookDetailState {}

class BookDetailInitial extends BookDetailState {}

class BookDetailLoading extends BookDetailState {}

class BookDetailLoaded extends BookDetailState {
  final BookDetail book;

  BookDetailLoaded(this.book);
}

class BookDetailError extends BookDetailState {
  final String message;

  BookDetailError(this.message);
}
