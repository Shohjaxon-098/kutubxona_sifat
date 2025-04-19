// lib/features/kutubxona/data/repositories/category_repository_impl.dart
import 'package:kutubxona/features/kutubxona/data/datasources/category_remote_data_source.dart';
import 'package:kutubxona/features/kutubxona/domain/entities/category.dart';
import 'package:kutubxona/features/kutubxona/domain/repository/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteDataSource remoteDataSource;

  CategoryRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Category>> getCategories() async {
    return await remoteDataSource.getCategories();
  }
}
