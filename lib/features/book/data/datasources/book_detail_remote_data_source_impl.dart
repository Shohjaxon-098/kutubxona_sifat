import 'package:dio/dio.dart';
import 'package:kutubxona/export.dart';
import '../model/book_detail_model.dart';
import 'book_detail_remote_data_source.dart';

class BookDetailRemoteDataSourceImpl implements BookDetailRemoteDataSource {
  final  dio=DioClient().dio;
  BookDetailRemoteDataSourceImpl();

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
      if (e.response?.statusCode == 404) {
        throw Exception('Kitob topilmadi');
      } else if (e.response?.statusCode == 500) {
        throw Exception('Server xatosi');
      } else {
        throw Exception('Tarmoq xatosi: ${e.message}');
      }
    }
  }
}
