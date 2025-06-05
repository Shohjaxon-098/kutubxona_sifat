import 'package:kutubxona/features/drawer/domain/entities/book_statistic_entity.dart';

class BookStatisticModel extends BookStatisticEntity {
  BookStatisticModel({
    required super.bookId,
    required super.imageId,
    required super.title,
    required super.author,
    required super.publishedDate,
    required super.totalReservations,
  });

  factory BookStatisticModel.fromJson(Map<String, dynamic> json) {
    return BookStatisticModel(
      bookId: json['book_id'],
      imageId: json['book__image'],
      title: json['book__name'],
      author: json['book__author'],
      publishedDate: DateTime.parse(json['book__published_date']),
      totalReservations: json['total'],
    );
  }
}
