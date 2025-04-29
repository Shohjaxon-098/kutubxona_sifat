
import 'package:kutubxona/features/kutubxona/domain/entities/book_entity.dart';
import 'package:kutubxona/features/kutubxona/domain/entities/category.dart';

abstract class HomeRepository {
  Future<List<CategoryEntity>> getCategories(String libraryId);
  Future<List<BookEntity>> getBooks();
   Future<List<BookEntity>> searchBooks(String query);
  // Boshqa metodlar ham bo'lishi mumkin
}

