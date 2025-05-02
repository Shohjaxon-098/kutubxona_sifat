import 'package:kutubxona/features/select_library/data/model/library_model.dart';

abstract class LibraryRemoteDataSource {
  Future<List<LibraryModel>> fetchLibraries();
}
