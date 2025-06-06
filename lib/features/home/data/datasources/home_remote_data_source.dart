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

  Future<List<BookModel>> fetchBooks({
    int? categoryId,
    int? year,
    String? ratings,
    String? search,
    String? language,
    String? author,
    int? page,
    int? pageSize,
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
      if (search != null && search.isNotEmpty) {
        queryParams['search'] = search;
      }
      if (language != null && language.isNotEmpty) {
        queryParams['language'] = language;
      }
      if (author != null && author.isNotEmpty) {
        queryParams['author'] = author;
      }
      if (page != null) {
        queryParams['page'] = page;
      }
      if (pageSize != null) {
        queryParams['page_size'] = pageSize;
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
