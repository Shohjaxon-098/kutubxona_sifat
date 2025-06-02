
import 'package:kutubxona/features/drawer/data/datasources/deficient_book_datasources.dart';
import 'package:kutubxona/features/drawer/domain/entities/deficient_book_entity.dart';
import 'package:kutubxona/features/drawer/domain/repositories/deficient_book_repository.dart';

class DeficientBooksRepositoryImpl implements DeficientBooksRepository {
  final DeficientBooksRemoteDataSource remote;

  DeficientBooksRepositoryImpl(this.remote);

  @override
  Future<List<DeficientBookEntity>> getDeficientBooks() {
    return remote.getDeficientBooks();
  }
}
