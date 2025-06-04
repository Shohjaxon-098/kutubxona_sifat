import 'package:kutubxona/export.dart';

class LibraryRemoteDataSourceImpl implements LibraryRemoteDataSource {
  final dio = DioClient().dio;
  LibraryRemoteDataSourceImpl();

  @override
  Future<List<LibraryModel>> fetchLibraries() async {
    try {
      final response = await dio.get('${AppConfig.baseUrl}/account/libraries/');

      final List data = response.data['results'];
      final libraries = data.map((e) => LibraryModel.fromJson(e)).toList();

      return libraries;
    } catch (e) {
      if (e is DioException) {
        final errorMessage = e.response?.data['detail'] ?? 'Unknown error';
        throw Exception('Network error: $errorMessage');
      } else {
        throw Exception('Unexpected error: $e');
      }
    }
  }
}
