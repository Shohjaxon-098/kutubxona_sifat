import 'package:dio/dio.dart';
import 'package:kutubxona/config/config_exports.dart';
import 'package:kutubxona/features/select_library/data/model/district_model.dart';
import 'package:kutubxona/features/select_library/domain/repository/district_repository.dart';
import '../../domain/entities/district_entity.dart';


class DistrictRepositoryImpl implements DistrictRepository {
  final Dio dio;

  DistrictRepositoryImpl(this.dio);

  @override
  Future<List<DistrictEntity>> getDistrictsByRegion(int regionId) async {
    final response = await dio.get('${AppConfig.baseUrl}/common/districts/', queryParameters: {
      'region': regionId,
    });
    return (response.data['results'] as List)
        .map((e) => DistrictModel.fromJson(e))
        .toList();
  }
}
