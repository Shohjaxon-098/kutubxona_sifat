// features/library/domain/repositories/library_repository.dart

import '../entities/library_entity.dart';

abstract class LibraryRepository {
  Future<List<LibraryEntity>> getLibraries();
}
