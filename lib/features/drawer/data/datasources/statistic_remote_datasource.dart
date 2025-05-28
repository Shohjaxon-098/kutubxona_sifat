import 'package:kutubxona/core/core_exports.dart';
import 'package:kutubxona/export.dart';
import 'package:kutubxona/features/drawer/data/model/statistic_model.dart';

abstract class StatisticRemoteDataSource {
  Future<StatisticModel> getStatistics(String libraryId);
}

class StatisticRemoteDataSourceImpl implements StatisticRemoteDataSource {
  final dio = DioClient().dio;

  StatisticRemoteDataSourceImpl();

  @override
  Future<StatisticModel> getStatistics(String libraryId) async {
    final token = await LocalStorage.getAccessToken();
    try {
      final response = await dio.get(
        '${AppConfig.baseUrl}/account/library-statistics/$libraryId/',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );
      return StatisticModel.fromJson(response.data);
    } on DioError catch (e) {
      // Xatolikni tahlil qilish
      if (e.response != null) {
        final statusCode = e.response?.statusCode;
        final data = e.response?.data;
        // Token yoki xatolik haqida aniq ma'lumotni qaytarish
        if (statusCode == 401) {
          throw Exception('Token invalid yoki muddat tugagan');
        }
        // Boshqa xatoliklar uchun aniq xabar
        throw Exception(
          'Server xatoligi: ${data['message'] ?? 'Noma’lum xatolik'}',
        );
      } else {
        // Tarmoq yoki boshqa xatoliklar
        throw Exception('Tarmoq xatosi yoki serverga ulanish imkoni yo‘q');
      }
    }
  }
}
