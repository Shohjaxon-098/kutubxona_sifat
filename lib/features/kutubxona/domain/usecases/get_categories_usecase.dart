import 'package:kutubxona/features/kutubxona/domain/entities/category.dart';
import 'package:kutubxona/features/kutubxona/domain/repository/home_repository.dart';

class GetCategoriesUseCase {
  final HomeRepository repository;

  GetCategoriesUseCase(this.repository);

  Future<List<CategoryEntity>> call() async {
    return repository.getCategories();
  }
}