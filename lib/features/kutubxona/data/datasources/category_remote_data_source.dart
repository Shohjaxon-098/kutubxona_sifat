// lib/features/kutubxona/data/datasources/category_remote_data_source.dart
import 'package:kutubxona/core/util/important.dart';
import 'package:kutubxona/features/kutubxona/domain/entities/category.dart';

class CategoryRemoteDataSource {
  final Dio dio;

  CategoryRemoteDataSource({required this.dio});

  Future<List<Category>> getCategories() async {final id = await AppConfig.libraryId.toString();
    final response = await dio.get('${AppConfig.baseUrl}/$id/categories/');
    List<Category> categories = (response.data as List)
        .map((categoryJson) => Category.fromJson(categoryJson))
        .toList();
    return categories;
  }
}
