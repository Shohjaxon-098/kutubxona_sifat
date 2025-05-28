// data/datasources/contribution_remote_data_source.dart
import 'package:dio/dio.dart';
import 'package:kutubxona/core/constants/app_config.dart';
import 'package:kutubxona/core/core_exports.dart';
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
      // xatolikni aniqroq qaytarish uchun
      throw Exception('Failed to fetch contributions: ${e.message}');
    }
  }
}
