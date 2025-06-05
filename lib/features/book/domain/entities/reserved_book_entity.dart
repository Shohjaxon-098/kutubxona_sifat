class ReserveBookEntity {
  final int? book;
  final int? reservationId;
  final String? takenAt;
  final String? message;

  ReserveBookEntity({this.takenAt, this.reservationId, this.message,this.book});
}
