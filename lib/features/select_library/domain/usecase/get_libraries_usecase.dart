import 'package:kutubxona/features/select_library/domain/entities/library_entity.dart';
import 'package:kutubxona/features/select_library/domain/repository/library_repository.dart';

class GetLibrariesUseCase {
  final LibraryRepository repository;

  GetLibrariesUseCase(this.repository);

  Future<List<LibraryEntity>> call() => repository.getLibraries();
}
