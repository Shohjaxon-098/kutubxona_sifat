import 'package:kutubxona/features/kutubxona/domain/entities/library_entity.dart';

class LibraryModel {
  final String id;
  final String name;
  final String address;
  final String district;
  final String region;

  LibraryModel({
    required this.id,
    required this.name,
    required this.address,
    required this.district,
    required this.region,
  });

  factory LibraryModel.fromJson(Map<String, dynamic> json) {
    return LibraryModel(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      district: json['district'],
      region: json['region'],
    );
  }

  LibraryEntity toEntity() {
    return LibraryEntity(
      id: id,
      name: name,
      address: address,
      district: district,
      region: region,
    );
  }
}

extension LibraryModelMapper on LibraryModel {
  LibraryEntity toEntity() {
    return LibraryEntity(
      id: id,
      name: name,
      address: address,
      district: district,
      region: region,
    );
  }
}
