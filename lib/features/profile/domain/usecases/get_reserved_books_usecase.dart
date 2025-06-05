import '../entities/reserved_book_entity.dart';
import '../repositories/reserved_book_repository.dart';

class GetReservedBooksUseCase {
  final ReservedBookRepository repository;

  GetReservedBooksUseCase(this.repository);

  Future<List<ReservedBookEntity>> call(String libraryId) {
    return repository.getReservedBooks(libraryId);
  }
}
