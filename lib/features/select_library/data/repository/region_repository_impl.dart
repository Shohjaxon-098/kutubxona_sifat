import 'package:dio/dio.dart';
import 'package:kutubxona/export.dart';
import 'package:kutubxona/features/select_library/data/model/region_model.dart';
import 'package:kutubxona/features/select_library/domain/repository/region_repository.dart';
import '../../domain/entities/region_entity.dart';

class RegionRepositoryImpl implements RegionRepository {
  final Dio dio;

  RegionRepositoryImpl(this.dio);

  @override
  Future<List<RegionEntity>> getRegions() async {
    final response = await dio.get('${AppConfig.baseUrl}/common/regions/');
    return (response.data['results'] as List)
        .map((e) => RegionModel.fromJson(e))
        .toList();
  }
}
