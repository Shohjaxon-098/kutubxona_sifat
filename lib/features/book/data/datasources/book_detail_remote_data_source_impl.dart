import 'package:dio/dio.dart';
import 'package:kutubxona/core/util/important.dart';
import '../model/book_detail_model.dart';
import 'book_detail_remote_data_source.dart';

class BookDetailRemoteDataSourceImpl implements BookDetailRemoteDataSource {
  final Dio dio;

  BookDetailRemoteDataSourceImpl({required this.dio});

  @override
  Future<BookDetailModel> getBookDetail(String libraryId, String slug) async {
    try {
      final response = await dio.get(
        '${AppConfig.baseUrl}/books/$libraryId/$slug/',
      );

      if (response.statusCode == 200) {
        return BookDetailModel.fromJson(response.data);
      } else {
        throw Exception('Kitob topilmadi');
      }
    } on DioException catch (e) {
      print('URL: ${AppConfig.baseUrl}/books/$libraryId/$slug/');

      throw Exception('Server xatosi: ${e.message}');
    }
  }
}
