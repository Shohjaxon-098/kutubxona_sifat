import '../../../domain/entities/review_request_entity.dart';

abstract class PostReviewEvent {}

class SubmitReview extends PostReviewEvent {
  final ReviewRequestEntity review;

  SubmitReview(this.review);
}
