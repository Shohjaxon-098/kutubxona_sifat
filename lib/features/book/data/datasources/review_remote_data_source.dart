import 'package:dio/dio.dart';
import 'package:kutubxona/core/constants/app_config.dart';
import 'package:kutubxona/core/services/local_storage.dart';
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
    try {
      final token = await LocalStorage.getAccessToken();
      final response = await dio.get(
        '${AppConfig.baseUrl}/books/$libraryId/$slug/reviews/',
        queryParameters: {'limit': limit, 'offset': offset},
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.data != null && response.data['results'] != null) {
        final results = response.data['results'] as List;
        return results
            .map((e) => ReviewModel.fromJson(e as Map<String, dynamic>))
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      // Handle errors (e.g., network issues, invalid response)
      print('Error fetching reviews: $e');
      return [];
    }
  }

  @override
  Future<void> postReview(ReviewRequestModel model) async {
    try {
      final token = await LocalStorage.getAccessToken();
      final data = model.toJson();
      print('POST data: $data');
      print('POST token: $token');
      await dio.post(
        '${AppConfig.baseUrl}/books/${AppConfig.libraryId.toString()}/reviews/',
        data: data, // Ensure you're sending the correct data format
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );
    } catch (e) {
      print('Error posting review: $e');
    }
  }
}
