import '../entities/review_entity.dart';

abstract class ReviewRepository {
  Future<List<ReviewEntity>> getReviews({
    required String libraryId,
    required String slug,
  });
}
