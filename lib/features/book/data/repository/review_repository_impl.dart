import 'package:kutubxona/features/book/data/datasources/review_remote_data_source.dart';
import 'package:kutubxona/features/book/domain/entities/review_entity.dart';
import 'package:kutubxona/features/book/domain/repository/review_repository.dart';

class ReviewRepositoryImpl implements ReviewRepository {
  final ReviewRemoteDataSource remoteDataSource;

  ReviewRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<ReviewEntity>> getReviews({
    required String libraryId,
    required String slug,
    int limit = 10,
    int offset = 0,
  }) async {
    final reviewModels = await remoteDataSource.getReviews(
      libraryId: libraryId,
      slug: slug,
      limit: limit,
      offset: offset,
    );

    return reviewModels;
  }
}
