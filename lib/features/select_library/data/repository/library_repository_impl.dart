import 'package:kutubxona/features/select_library/data/datasources/library_remote_datasource.dart';
import 'package:kutubxona/features/select_library/domain/entities/library_entity.dart';
import 'package:kutubxona/features/select_library/domain/repository/library_repository.dart';

class LibraryRepositoryImpl implements LibraryRepository {
  final LibraryRemoteDataSource remoteDataSource;

  LibraryRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<LibraryEntity>> getLibraries() async {
    try {
      final models = await remoteDataSource.fetchLibraries();
      return models.map((model) => model.toEntity()).toList();
    } catch (e) {
      throw Exception("Failed to fetch libraries: $e");
    }
  }
}
