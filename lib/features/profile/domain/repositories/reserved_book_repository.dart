import '../entities/reserved_book_entity.dart';

abstract class ReservedBookRepository {
  Future<List<ReservedBookEntity>> getReservedBooks(String libraryId);
}
