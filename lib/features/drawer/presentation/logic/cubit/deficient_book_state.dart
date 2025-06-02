import 'package:kutubxona/features/drawer/domain/entities/deficient_book_entity.dart';

abstract class DeficientBooksState {}

class DeficientBooksInitial extends DeficientBooksState {}

class DeficientBooksLoading extends DeficientBooksState {}

class DeficientBooksLoaded extends DeficientBooksState {
  final List<DeficientBookEntity> books;

  DeficientBooksLoaded(this.books);
}

class DeficientBooksError extends DeficientBooksState {
  final String message;

  DeficientBooksError(this.message);
}
