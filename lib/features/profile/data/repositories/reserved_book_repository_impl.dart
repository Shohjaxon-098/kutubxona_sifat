import '../../domain/entities/reserved_book_entity.dart';
import '../../domain/repositories/reserved_book_repository.dart';
import '../datasources/reserved_book_remote_datasource.dart';

class ReservedBookRepositoryImpl implements ReservedBookRepository {
  final ReservedBookRemoteDataSource remoteDataSource;

  ReservedBookRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<ReservedBookEntity>> getReservedBooks(String libraryId) async {
    final models = await remoteDataSource.getReservedBooks(libraryId);
    return models.map((model) => model as ReservedBookEntity).toList();
  }
}
