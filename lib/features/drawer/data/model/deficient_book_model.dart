import 'package:kutubxona/features/drawer/domain/entities/deficient_book_entity.dart';

class DeficientBookModel extends DeficientBookEntity {
  DeficientBookModel({
    required super.name,
    required super.image,
    required super.author,
    required super.publication,
    required super.publishedDate,
    required super.stock,
    required super.bookedCount,
  });

  factory DeficientBookModel.fromJson(Map<String, dynamic> json) {
    return DeficientBookModel(
      name: json['name'],
      image: json['image'],
      author: json['author'],
      publication: json['publication'],
      publishedDate: json['published_date'],
      stock: json['stock'],
      bookedCount: json['booked_count'],
    );
  }
}
