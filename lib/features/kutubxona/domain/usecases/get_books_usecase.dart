import 'package:kutubxona/core/error/failure.dart';
import 'package:kutubxona/features/kutubxona/domain/repository/book_repository.dart';

import 'package:kutubxona/features/kutubxona/domain/entities/book_entity.dart';
import 'package:dartz/dartz.dart';

class GetBooksUseCase {
  final BookRepository repository;

  GetBooksUseCase(this.repository);

  Future<Either<Failure, List<BookEntity>>> call() async {
    return await repository.getBooks();
  }
}
