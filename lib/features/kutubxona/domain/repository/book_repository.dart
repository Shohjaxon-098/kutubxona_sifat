import 'package:dartz/dartz.dart';
import 'package:kutubxona/core/error/failure.dart';
import 'package:kutubxona/features/kutubxona/domain/entities/book_entity.dart';

abstract class BookRepository {
  Future<Either<Failure, List<BookEntity>>> getBooks();
}
