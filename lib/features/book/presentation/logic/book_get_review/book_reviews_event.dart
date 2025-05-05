import 'package:kutubxona/features/book/domain/entities/review_entity.dart';
import 'package:kutubxona/features/book/domain/entities/review_request_entity.dart';

abstract class ReviewEvent {}

class FetchReviews extends ReviewEvent {
  final String libraryId;
  final String slug;
  final int limit;
  final int offset;

  FetchReviews({
    required this.libraryId,
    required this.slug,
    this.limit = 10,
    this.offset = 0,
  });
}

class AddReview extends ReviewEvent {
  final ReviewEntity review;

  AddReview(this.review);
}
