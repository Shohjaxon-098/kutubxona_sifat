
import 'package:kutubxona/features/home/domain/entities/book_entity.dart';
import 'package:kutubxona/features/home/domain/entities/category.dart';

abstract class HomeRepository {
  Future<List<CategoryEntity>> getCategories(String libraryId);
  Future<List<BookEntity>> getBooks();
   Future<List<BookEntity>> searchBooks(String query);
  // Boshqa metodlar ham bo'lishi mumkin
}

