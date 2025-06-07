class BookStatisticEntity {
  final int? bookId;
  final int? imageId;
  final String? title;
  final String? author;
  final DateTime? publishedDate;
  final int? totalReservations;

  BookStatisticEntity({
    required this.bookId,
    required this.imageId,
    required this.title,
    required this.author,
    required this.publishedDate,
    required this.totalReservations,
  });
}
