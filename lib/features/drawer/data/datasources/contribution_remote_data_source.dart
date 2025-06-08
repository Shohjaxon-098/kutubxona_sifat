// data/datasources/contribution_remote_data_source.dart
import 'package:dio/dio.dart';
import 'package:kutubxona/core/constants/app_config.dart';
import 'package:kutubxona/core/core_exports.dart';
import 'package:kutubxona/core/error/exeptions.dart';
import 'package:kutubxona/features/drawer/data/model/contribution.dart';

abstract class ContributionRemoteDataSource {
  Future<ContributionModel> fetchContributions(String libraryId);
}

class ContributionRemoteDataSourceImpl implements ContributionRemoteDataSource {
  final dio = DioClient().dio;

  ContributionRemoteDataSourceImpl();

  @override
  Future<ContributionModel> fetchContributions(String libraryId) async {
    try {
      final response = await dio.get(
        '${AppConfig.baseUrl}/common/contributions/$libraryId/',
      );

      return ContributionModel.fromJson(response.data);
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
