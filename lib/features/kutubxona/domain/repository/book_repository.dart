import '../entities/book_entity.dart';

abstract class BookRepository {
  Future<List<BookEntity>> searchBooks(String query);
}
