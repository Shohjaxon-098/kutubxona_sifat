import 'package:kutubxona/features/book/data/model/reserved_book_model.dart';
import 'package:kutubxona/features/profile/data/model/reserved_book_model.dart';

abstract class ReserveBookState {}

class ReserveBookInitial extends ReserveBookState {}

class ReserveBookLoading extends ReserveBookState {}

class ReserveBookSuccess extends ReserveBookState {
  final ReserveBookModel reserveBook;
  ReserveBookSuccess(this.reserveBook);
}

class CancelReservationSuccess extends ReserveBookState {}

class ReserveBookError extends ReserveBookState {
  final String message;
  ReserveBookError(this.message);
}
