abstract class ReserveBookEvent {}

class ReserveBookRequested extends ReserveBookEvent {
  final int bookId;
  ReserveBookRequested(this.bookId);
}

class CancelReservationRequested extends ReserveBookEvent {
  final int? reservationId;
  CancelReservationRequested(this.reservationId);
}
