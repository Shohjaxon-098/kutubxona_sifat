import 'package:kutubxona/features/book/domain/repository/review_repository.dart';

import '../entities/review_request_entity.dart';

class PostReviewUseCase {
  final ReviewRepository repository;

  PostReviewUseCase(this.repository);

  Future<void> call(ReviewRequestEntity review) {
    return repository.postReview(review);
  }
}
