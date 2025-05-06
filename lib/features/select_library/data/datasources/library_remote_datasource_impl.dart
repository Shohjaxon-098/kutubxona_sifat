import 'package:kutubxona/export.dart';

class LibraryRemoteDataSourceImpl implements LibraryRemoteDataSource {
  final Dio dio;

  LibraryRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<LibraryModel>> fetchLibraries() async {
    try {
      final response = await dio.get('${AppConfig.baseUrl}/account/libraries/');

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
