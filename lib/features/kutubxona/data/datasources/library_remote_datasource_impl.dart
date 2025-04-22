import 'package:kutubxona/core/util/important.dart';
import 'package:kutubxona/features/kutubxona/data/datasources/library_remote_datasource.dart';
import 'package:kutubxona/features/kutubxona/data/models/library_model.dart';

class LibraryRemoteDataSourceImpl implements LibraryRemoteDataSource {
  final Dio dio;

  LibraryRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<LibraryModel>> fetchLibraries() async {
    try {
      final response = await dio.get('${AppConfig.baseUrl}/account/libraries/');
      print('Region response: ${response.data}'); // Debug uchun
      final List data = response.data['results'];
      final libraries = data.map((e) => LibraryModel.fromJson(e)).toList();
      LocalStorage.saveLibraryId(libraries.first.id);
      return libraries;
    } catch (e) {
      print('getRegions error: $e');
      rethrow;
    }
  }
}
