import 'package:kutubxona/core/constants/api_constants.dart';
import 'package:kutubxona/core/network/dio_client.dart';
import 'package:kutubxona/features/kutubxona/data/models/book_model.dart';
import 'package:kutubxona/features/kutubxona/data/models/category_model.dart';

class HomeRemoteDataSource {
  final dio = DioClient().dio;

  Future<List<CategoryModel>> fetchCategories() async {
    final response = await dio.get(ApiConstants.categories);
    return (response.data['data'] as List)
        .map((json) => CategoryModel.fromJson(json))
        .toList();
  }

  Future<List<BookModel>> fetchBooks() async {
    final response = await dio.get(ApiConstants.books);
    return (response.data['results'] as List)
        .map((json) => BookModel.fromJson(json))
        .toList();
  }
}