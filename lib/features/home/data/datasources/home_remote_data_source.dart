import 'package:kutubxona/export.dart';

class HomeRemoteDataSource {
  final dio = DioClient().dio;
  // Fetch categories with error handling
  Future<List<CategoryModel>> fetchCategories(String libraryId) async {
    try {
      final id = await AppConfig.libraryId.toString();
      final response = await dio.get(
        "${AppConfig.baseUrl}/books/$id/categories/",
      );
      if (response.statusCode == 200) {
        return (response.data['results'] as List)
            .map((json) => CategoryModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      rethrow; // Re-throw to allow higher layers to handle it
    }
  }

  // Fetch books with error handling
  Future<List<BookModel>> fetchBooks({
    int? categoryId,
    String? year,
    List<int>? ratings,
  }) async {
    try {
      final id = await AppConfig.libraryId;

      final queryParams = <String, dynamic>{};

      if (categoryId != null) {
        queryParams['category'] = categoryId;
      }
      if (year != null) {
        queryParams['year'] = year;
      }
      if (ratings != null && ratings.isNotEmpty) {
        queryParams['rating'] = ratings;
      }

      final response = await dio.get(
        "${AppConfig.baseUrl}/books/$id/",
        queryParameters: queryParams,
      );

      if (response.statusCode == 200) {
        return (response.data['results'] as List)
            .map((json) => BookModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to load books');
      }
    } catch (e) {
      print('Error fetching books: $e');
      rethrow;
    }
  }
}
