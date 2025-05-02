import 'package:kutubxona/features/book/domain/repository/review_repository.dart';

import '../entities/review_entity.dart';

class GetReviewsUseCase {
  final ReviewRepository repository;

  GetReviewsUseCase(this.repository);

  Future<List<ReviewEntity>> call(String slug,String libraryId,) {
    return repository.getReviews( libraryId: libraryId, slug: slug,);
  }
}
