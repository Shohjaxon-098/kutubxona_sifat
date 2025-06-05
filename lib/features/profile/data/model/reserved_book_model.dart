import 'package:kutubxona/features/home/data/model/book_model.dart';
import 'package:kutubxona/features/profile/domain/entities/reserved_book_entity.dart';

class ReservedBookModel extends ReservedBookEntity {
  ReservedBookModel({
    required super.id,
    required super.book,
    required super.takenAt,
    super.dueDate,
    super.returned_at,
    super.status,
  });
  factory ReservedBookModel.fromJson(Map<String, dynamic> json) {
    return ReservedBookModel(
      id: json['id'] ?? 0,
      book:
          json['book'] != null
              ? BookModel.fromJson(json['book'] as Map<String, dynamic>)
              : throw Exception("Book data is null"), // yoki boshqacha handling
      takenAt: json['taken_at'] ?? '',
      dueDate: json['due_date'] ?? '',
      status: json['status'] ?? '',
      returned_at: json['returned_at'] ??'',
    );
  }
}
