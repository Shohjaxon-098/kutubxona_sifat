import 'package:kutubxona/features/book/domain/entities/reserved_book_entity.dart';

abstract class BookReserveRepository {
  Future<ReserveBookEntity> reserveBook({required int bookId});
}
