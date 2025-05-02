import 'package:kutubxona/features/home/domain/entities/category.dart';
import 'package:kutubxona/features/home/domain/repository/home_repository.dart';

class GetCategoriesUseCase {
  final HomeRepository repository;

  GetCategoriesUseCase(this.repository);

  Future<List<CategoryEntity>> call(String libraryId) async {
    return repository.getCategories(libraryId);
  }
}