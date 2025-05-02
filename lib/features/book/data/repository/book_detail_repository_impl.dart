import 'package:kutubxona/features/book/domain/repository/book_detail_repository.dart';

import '../../domain/entities/book_detail.dart';
import '../datasources/book_detail_remote_data_source.dart';

class BookDetailRepositoryImpl implements BookDetailRepository {
  final BookDetailRemoteDataSource remoteDataSource;

  BookDetailRepositoryImpl({required this.remoteDataSource});

  @override
  Future<BookDetail> getBookDetail(String libraryId,String slug) async {
    final model = await remoteDataSource.getBookDetail(libraryId,slug);
    return model;
  }
}
