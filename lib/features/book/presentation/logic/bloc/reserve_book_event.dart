part of 'reserve_book_bloc.dart';

abstract class ReserveBookEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ReserveBookPressed extends ReserveBookEvent {
  final int bookId;

  ReserveBookPressed(this.bookId);

  @override
  List<Object> get props => [bookId];
}
