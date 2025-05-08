import 'package:kutubxona/features/book/domain/entities/review_entity.dart';

abstract class ReviewEvent {}

class FetchReviews extends ReviewEvent {

  FetchReviews({
    required this.libraryId,
    required this.slug,
    this.limit = 10,
    this.offset = 0,
  });
  final String libraryId;
  final String slug;
  final int limit;
  final int offset;
}

class AddReview extends ReviewEvent {

  AddReview(this.review);
  final ReviewEntity review;
}
