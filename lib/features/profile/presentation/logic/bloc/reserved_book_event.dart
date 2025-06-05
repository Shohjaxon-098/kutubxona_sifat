part of 'reserved_book_bloc.dart';

abstract class ReservedBookEvent {}

class LoadReservedBooks extends ReservedBookEvent {
  final String libraryId;
  LoadReservedBooks(this.libraryId);
}
