import 'package:kutubxona/features/kutubxona/domain/entities/book_entity.dart';
import 'package:kutubxona/features/kutubxona/domain/entities/category.dart';

abstract class HomeRepository {
  Future<List<CategoryEntity>> getCategories();
  Future<List<BookEntity>> getBooks();
}
