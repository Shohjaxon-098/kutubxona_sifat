part of 'reserved_book_bloc.dart';

abstract class ReservedBookState {}

class ReservedBookInitial extends ReservedBookState {}

class ReservedBookLoading extends ReservedBookState {}

class ReservedBookLoaded extends ReservedBookState {
  final List<ReservedBookEntity> books;
  ReservedBookLoaded(this.books);
}

class ReservedBookError extends ReservedBookState {
  final String message;
  ReservedBookError(this.message);
}
