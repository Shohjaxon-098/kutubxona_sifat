import '../../domain/entities/review_request_entity.dart';

class ReviewRequestModel {
  final String score;
  final String review;
  final int book;

  ReviewRequestModel({
    required this.score,
    required this.review,
    required this.book,
  });

  Map<String, dynamic> toJson() {
    return {
      'score': score.toString(),
      'review': review,
      'book': book,
    };
  }

  factory ReviewRequestModel.fromEntity(ReviewRequestEntity entity) {
    return ReviewRequestModel(
      score: entity.score,
      review: entity.review,
      book: entity.bookId,
    );
  }
}
