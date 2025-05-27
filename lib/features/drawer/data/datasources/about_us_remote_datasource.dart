import 'package:kutubxona/core/constants/app_config.dart';
import 'package:kutubxona/core/core_exports.dart';
import 'package:kutubxona/features/drawer/data/model/about_us_model.dart';

abstract class AboutUsRemoteDataSource {
  Future<AboutUsModel> getAboutUs();
}

class AboutUsRemoteDataSourceImpl implements AboutUsRemoteDataSource {
  final  dio=DioClient().dio;
  AboutUsRemoteDataSourceImpl();

  @override
  Future<AboutUsModel> getAboutUs() async {
    try {
      final response = await dio.get(
        '${AppConfig.baseUrl}/common/about-us/${AppConfig.libraryId}/',
      );
      return AboutUsModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(
        'Сервер хатоси: ${e.response?.statusCode ?? ''} - ${e.message}',
      );
    } catch (e) {
      throw Exception('Номаълум хатолик: ${e.toString()}');
    }
  }
}
