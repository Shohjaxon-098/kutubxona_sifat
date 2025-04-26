import 'package:dartz/dartz.dart';
import 'package:kutubxona/core/error/failure.dart';
import 'package:kutubxona/features/kutubxona/domain/entities/book_entity.dart';
import 'package:kutubxona/features/kutubxona/domain/repository/home_repository.dart';

class SearchBooksUseCase {
  final HomeRepository repository;

  SearchBooksUseCase(this.repository);

  Future<Either<Failure, List<BookEntity>>> call(String query) async {
    return await repository.searchBooks(query);
  }
}
