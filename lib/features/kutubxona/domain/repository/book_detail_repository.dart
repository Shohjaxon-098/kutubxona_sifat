import '../entities/book_detail.dart';

abstract class BookDetailRepository {
  Future<BookDetail> getBookDetail(String libraryId,String slug);
}
