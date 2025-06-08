import 'package:kutubxona/core/constants/app_config.dart';
import 'package:kutubxona/core/core_exports.dart';
import 'package:kutubxona/core/error/exeptions.dart';
import 'package:kutubxona/features/drawer/data/model/about_us_model.dart';

abstract class AboutUsRemoteDataSource {
  Future<AboutUsModel> getAboutUs();
}

class AboutUsRemoteDataSourceImpl implements AboutUsRemoteDataSource {
  final dio = DioClient().dio;

  AboutUsRemoteDataSourceImpl();

  @override
  Future<AboutUsModel> getAboutUs() async {
    try {
      final response = await dio.get(
        '${AppConfig.baseUrl}/common/about-us/${AppConfig.libraryId}/',
      );
      return AboutUsModel.fromJson(response.data);
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      final data = e.response?.data;
      final errorMessage =
          data is Map<String, dynamic>
              ? data['detail'] ?? data['message'] ?? e.message
              : e.message;

      throw ServerException(message: 'Хатолик $statusCode: $errorMessage');
    } catch (e) {
      throw ServerException(message: 'Номаълум хатолик: ${e.toString()}');
    }
  }
}
