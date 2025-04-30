import 'package:kutubxona/core/constants/important.dart';

class HomeRemoteDataSource {
  final dio = DioClient().dio;

  // Fetch categories with error handling
  Future<List<CategoryModel>> fetchCategories(String libraryId) async {
    try {
      final id = await AppConfig.libraryId;
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
      print('Error fetching categories: $e');
      rethrow; // Re-throw to allow higher layers to handle it
    }
  }

  // Fetch books with error handling
  Future<List<BookModel>> fetchBooks() async {
    try {
      final id = await AppConfig.libraryId;
      final response = await dio.get("${AppConfig.baseUrl}/books/$id/");
      if (response.statusCode == 200) {
        return (response.data['results'] as List)
            .map((json) => BookModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to load books');
      }
    } catch (e) {
      print('Error fetching books: $e');
      rethrow; // Re-throw to allow higher layers to handle it
    }
  }
}
