import 'package:dartz/dartz.dart';
import 'package:kutubxona/core/error/failure.dart';
import 'package:kutubxona/features/kutubxona/data/datasources/book_remote_data_source.dart';
import 'package:kutubxona/features/kutubxona/domain/repository/book_repository.dart';
import '../../domain/entities/book_entity.dart';

class BookRepositoryImpl implements BookRepository {
  final BookRemoteDataSource remoteDataSource;

  BookRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<BookEntity>>> getBooks() async {
    try {
      final books = await remoteDataSource.getBooks();
      return Right(books);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
