
import 'package:kutubxona/features/drawer/domain/entities/top_reader_entity.dart';

class TopReaderModel extends TopReaderEntity {
  TopReaderModel({
    required super.memberId,
    required super.firstName,
    required super.lastName,
    required super.total,
  });

  factory TopReaderModel.fromJson(Map<String, dynamic> json) {
    return TopReaderModel(
      memberId: json['library_member_id'],
      firstName: json['library_member__first_name'],
      lastName: json['library_member__last_name'],
      total: json['total'],
    );
  }
}
