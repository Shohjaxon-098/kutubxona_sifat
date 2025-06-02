import 'package:kutubxona/features/drawer/domain/entities/deficient_book_entity.dart';
import 'package:kutubxona/features/drawer/domain/repositories/deficient_book_repository.dart';

class GetDeficientBooksUseCase {
  final DeficientBooksRepository repository;

  GetDeficientBooksUseCase(this.repository);

  Future<List<DeficientBookEntity>> call() {
    return repository.getDeficientBooks();
  }
}
