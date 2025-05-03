class ReviewRequestEntity {
  final String score;
  final String review;
  final int bookId;

  ReviewRequestEntity({
    required this.score,
    required this.review,
    required this.bookId,
  });
}
