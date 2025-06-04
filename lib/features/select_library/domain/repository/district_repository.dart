import 'package:kutubxona/features/select_library/domain/entities/district_entity.dart';

abstract class DistrictRepository {
  Future<List<DistrictEntity>> getDistrictsByRegion(int regionId);
}
