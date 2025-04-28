import 'package:dartz/dartz.dart';
import 'package:kutubxona/core/error/failure.dart';
import 'package:kutubxona/features/kutubxona/domain/entities/book_entity.dart';
import 'package:kutubxona/features/kutubxona/domain/entities/category.dart';

abstract class HomeRepository {
  Future<List<CategoryEntity>> getCategories(String libraryId);
  Future<List<BookEntity>> getBooks();
   Future<Either<Failure, List<BookEntity>>> searchBooks(String query);
  // Boshqa metodlar ham bo'lishi mumkin
}

