
import 'package:kutubxona/features/home/domain/entities/book_entity.dart';
import 'package:kutubxona/features/home/domain/repository/home_repository.dart';

class GetBooksUseCase {
  final HomeRepository repository;

  GetBooksUseCase(this.repository);

  Future<List<BookEntity>> call() async {
    return repository.getBooks();
  }
}
