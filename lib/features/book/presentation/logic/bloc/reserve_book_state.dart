part of 'reserve_book_bloc.dart';

abstract class ReserveBookState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ReserveBookInitial extends ReserveBookState {}

class ReserveBookLoading extends ReserveBookState {}

class ReserveBookSuccess extends ReserveBookState {
  final ReservedBookEntity reservedBook;

  ReserveBookSuccess(this.reservedBook);

  @override
  List<Object?> get props => [reservedBook];
}

class ReserveBookError extends ReserveBookState {
  final String message;

  ReserveBookError(this.message);

  @override
  List<Object?> get props => [message];
}
