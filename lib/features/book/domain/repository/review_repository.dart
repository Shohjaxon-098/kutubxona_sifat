import 'package:kutubxona/features/book/domain/entities/review_request_entity.dart';

import '../entities/review_entity.dart';

abstract class ReviewRepository {
  Future<List<ReviewEntity>> getReviews({
    required String libraryId,
    required String slug,
  });
    Future<void> postReview(ReviewRequestEntity review);
}
