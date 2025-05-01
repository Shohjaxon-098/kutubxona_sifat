import 'package:kutubxona/features/kutubxona/domain/repository/book_detail_repository.dart';

import '../entities/book_detail.dart';

class GetBookDetail {
  final BookDetailRepository repository;

  GetBookDetail(this.repository);

  Future<BookDetail> call(String libraryId,String slug) async {
    return await repository.getBookDetail(libraryId,slug);
  }
}
