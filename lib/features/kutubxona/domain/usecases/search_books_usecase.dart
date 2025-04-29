import 'package:kutubxona/features/kutubxona/domain/entities/book_entity.dart';
import 'package:kutubxona/features/kutubxona/domain/repository/home_repository.dart';

class SearchBooksUseCase {
  final HomeRepository repository;

  SearchBooksUseCase(this.repository);

  Future<List<BookEntity>> call(String query) async {
    final allBooks = await repository.searchBooks(query);
    return allBooks
        .where(
          (book) =>
              book.name.toLowerCase().contains(query.toLowerCase()) ||
              book.author.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
  }
}
