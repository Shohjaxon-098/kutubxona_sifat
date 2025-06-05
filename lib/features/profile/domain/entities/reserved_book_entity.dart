import 'package:kutubxona/features/home/domain/entities/book_entity.dart';

class ReservedBookEntity {
  final int id;
  final BookEntity book;
  final String? takenAt;
  final String? dueDate;
  final String? returned_at;
  final String? status;

  ReservedBookEntity({
    required this.id,
    required this.book,
    this.takenAt,
    this.dueDate,
    this.returned_at,
    this.status,
  });
}
