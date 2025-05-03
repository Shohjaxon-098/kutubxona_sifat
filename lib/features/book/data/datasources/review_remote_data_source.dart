import 'package:dio/dio.dart';
import 'package:kutubxona/core/constants/app_config.dart';
import 'package:kutubxona/features/book/data/model/review_model.dart';
import 'package:kutubxona/features/book/data/model/review_request_model.dart';

abstract class ReviewRemoteDataSource {
  Future<List<ReviewModel>> getReviews({
    required String libraryId,
    required String slug,
    int limit,
    int offset,
  });
  Future<void> postReview(ReviewRequestModel model);
}

class ReviewRemoteDataSourceImpl implements ReviewRemoteDataSource {
  final Dio dio;

  ReviewRemoteDataSourceImpl(this.dio);

  @override
  Future<List<ReviewModel>> getReviews({
    required String libraryId,
    required String slug,
    int limit = 10,
    int offset = 0,
  }) async {
    final response = await dio.get(
      '${AppConfig.baseUrl}/books/$libraryId/$slug/reviews/',
      queryParameters: {'limit': limit, 'offset': offset},
    );

    if (response.data != null && response.data['results'] != null) {
      final results = response.data['results'] as List;
      print(response.data);
      return results
          .map((e) => ReviewModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      return [];
    }
  }

  @override
  Future<void> postReview(ReviewRequestModel model) async {
    await dio.post('${AppConfig.baseUrl}/books/${AppConfig.libraryId.toString()}/reviews/', data: model.toJson());
  }
}
