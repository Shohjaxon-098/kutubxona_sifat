import 'package:kutubxona/core/util/important.dart';
import 'package:kutubxona/features/kutubxona/data/datasources/library_remote_datasource.dart';
import 'package:kutubxona/features/kutubxona/data/models/library_model.dart';

class LibraryRemoteDataSourceImpl implements LibraryRemoteDataSource {
  final Dio dio;

  LibraryRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<LibraryModel>> fetchLibraries() async {
    final response = await dio.get('$baseUrl/account/libraries/');
    return (response.data as List)
        .map((json) => LibraryModel.fromJson(json))
        .toList();
  }
}
