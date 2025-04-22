import 'package:kutubxona/features/kutubxona/data/models/library_model.dart';

abstract class LibraryRemoteDataSource {
  Future<List<LibraryModel>> fetchLibraries();
}
