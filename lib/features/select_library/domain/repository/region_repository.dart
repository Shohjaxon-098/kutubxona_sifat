import 'package:kutubxona/features/select_library/domain/entities/region_entity.dart';

abstract class RegionRepository {
  Future<List<RegionEntity>> getRegions();
}
