import 'package:kutubxona/features/book/domain/entities/reserved_book_entity.dart';
import 'package:kutubxona/features/book/domain/repository/book_reserved_repository.dart';

class ReserveBookUseCase {
  final BookReserveRepository repository;

  ReserveBookUseCase(this.repository);

  Future<ReserveBookEntity> call(int bookId) {
    return repository.reserveBook(bookId: bookId);
  }
}
