import '../../domain/entities/district_entity.dart';

class DistrictModel extends DistrictEntity {
  DistrictModel({required super.id, required super.name, required super.region});

  factory DistrictModel.fromJson(Map<String, dynamic> json) {
    return DistrictModel(
      id: json['id'],
      name: json['name'],
      region: json['region'],
    );
  }
}
