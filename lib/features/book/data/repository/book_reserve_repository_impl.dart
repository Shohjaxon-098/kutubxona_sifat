
import 'package:kutubxona/features/book/data/datasources/book_reserve_remote_data_source.dart';
import 'package:kutubxona/features/book/data/model/reserved_book_model.dart';
import 'package:kutubxona/features/book/domain/repository/book_reserved_repository.dart';




class BookReserveRepositoryImpl implements BookReserveRepository {
  final BookReserveRemoteDataSource remoteDataSource;

  BookReserveRepositoryImpl(this.remoteDataSource);

  @override
  Future<ReserveBookModel> reserveBook({required int bookId}) {
    return remoteDataSource.reserveBook(bookId);
  }
}
