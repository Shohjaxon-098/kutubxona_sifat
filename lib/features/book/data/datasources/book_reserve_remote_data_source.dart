import 'package:kutubxona/export.dart';
import 'package:kutubxona/features/book/data/model/reserved_book_model.dart';

abstract class BookReserveRemoteDataSource {
  Future<ReserveBookModel> reserveBook(int bookId);
  Future<void> cancelReservation(int reservationId);
}

class BookReserveRemoteDataSourceImpl implements BookReserveRemoteDataSource {
  final dio = DioClient().dio;

  BookReserveRemoteDataSourceImpl();

  @override
  Future<ReserveBookModel> reserveBook(int bookId) async {
    final token = await LocalStorage.getAccessToken();

    try {
      final response = await dio.post(
        '${AppConfig.baseUrl}/books/${AppConfig.libraryId}/reserve-book/',
        data: {'book': bookId},
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      print("✅ Response data: ${response.data}");

      return ReserveBookModel.fromJson(response.data);
    } on DioException catch (e) {
      final errorData = e.response?.data;

      if (e.response != null) {
        print(e.response?.data);
        throw Exception('$errorData');
      } else {
        throw Exception('Tarmoq xatosi: ${e.message}');
      }
    } catch (e) {
      throw Exception('Noma\'lum xatolik: $e');
    }
  }

  @override
  Future<void> cancelReservation(int reservationId) async {
    final token = await LocalStorage.getAccessToken();

    try {
      final response = await dio.put(
        '${AppConfig.baseUrl}/books/${AppConfig.libraryId}/reserved-book/$reservationId/cancel/',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      print("✅ Cancel response: ${response.data}");
    } on DioException catch (e) {
      if (e.response != null) {
        // Serverdan kelgan aniq xabarni olamiz
        final statusCode = e.response?.statusCode ?? 0;
        final message =
            e.response?.data?['message'] ??
            e.response?.statusMessage ??
            'Xatolik yuz berdi';
        throw Exception('Xato ($statusCode): $message');
      } else {
        // Tarmoq xatoliklari
        throw Exception(
          'Internet ulanmagan yoki serverga ulanib bo‘lmadi: ${e.message}',
        );
      }
    } catch (e) {
      throw Exception('Nomaʼlum xatolik: $e');
    }
  }
}
