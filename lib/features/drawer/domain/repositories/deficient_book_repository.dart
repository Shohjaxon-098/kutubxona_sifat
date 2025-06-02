import 'package:kutubxona/features/drawer/domain/entities/deficient_book_entity.dart';

abstract class DeficientBooksRepository {
  Future<List<DeficientBookEntity>> getDeficientBooks();
}
