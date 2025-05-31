import 'package:kutubxona/export.dart';
import 'package:kutubxona/features/book/data/model/reserved_book_model.dart';

abstract class BookReserveRemoteDataSource {
  Future<ReservedBookModel> reserveBook(int bookId);
}

class BookReserveRemoteDataSourceImpl implements BookReserveRemoteDataSource {
  final dio = DioClient().dio;

  BookReserveRemoteDataSourceImpl();

  @override
  Future<ReservedBookModel> reserveBook(int bookId) async {
    final token = await LocalStorage.getAccessToken();

    try {
      final response = await dio.post(
        '${AppConfig.baseUrl}/books/${AppConfig.libraryId}/reserve-book/',
        data: {'book': bookId},
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      print("✅ Response data: ${response.data}");

      return ReservedBookModel.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response != null) {
        print("❌ Server Error:");
        print("🔗 URL: ${e.requestOptions.uri}");
        print("📦 Data: ${e.response?.data}");
        print("📄 Status Code: ${e.response?.statusCode}");
        print(token);
        final errorMessage =
            e.response?.data['detail'] ??
            e.response?.data.toString() ??
            'Xatolik yuz berdi (status: ${e.response?.statusCode})';

        throw Exception('Server xatoligi: $errorMessage');
      } else {
        print("❌ Tarmoq xatosi: ${e.message}");
        throw Exception('Tarmoq xatosi: ${e.message}');
      }
    } catch (e) {
      print("❌ Noma'lum xatolik: $e");
      throw Exception('Noma\'lum xatolik: $e');
    }
  }
}
