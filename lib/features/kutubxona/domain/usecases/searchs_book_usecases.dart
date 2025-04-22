import 'package:kutubxona/features/kutubxona/domain/repository/book_repository.dart';

import 'package:kutubxona/features/kutubxona/domain/entities/book_entity.dart';

class SearchBooks {
  final BookRepository repository;

  SearchBooks(this.repository);

  Future<List<BookEntity>> call(String query) async {
    return repository.searchBooks(query);
  }
}
