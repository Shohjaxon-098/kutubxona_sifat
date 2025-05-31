import 'package:kutubxona/features/book/domain/entities/reserved_book_entity.dart';

class ReservedBookModel extends ReservedBookEntity {
  ReservedBookModel({DateTime? takenAt, int? id})
    : super(takenAt: takenAt, id: id);

  factory ReservedBookModel.fromJson(Map<String, dynamic> json) {
    return ReservedBookModel(
      takenAt:
          json['taken_at'] != null ? DateTime.parse(json['taken_at']) : null,
      id: json['id'] != null ? int.tryParse(json['id'].toString()) : null,
    );
  }
}
