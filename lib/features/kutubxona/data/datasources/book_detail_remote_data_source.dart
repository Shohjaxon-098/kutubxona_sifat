import '../models/book_detail_model.dart';

abstract class BookDetailRemoteDataSource {
  Future<BookDetailModel> getBookDetail(String libraryId,String slug);
}
