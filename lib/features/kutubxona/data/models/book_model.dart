import 'package:kutubxona/features/kutubxona/domain/entities/book_entity.dart';

class BookModel extends BookEntity {
  BookModel({
    required super.id,
    required super.slug,
    required super.name,
    required super.category,
    required super.image,
    super.rating,
    required super.author,
    required super.publication,
    super.publishedDate,
    super.reviewsCount,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      id: json['id'],
      slug: json['slug'],
      name: json['name'],
      category: json['category'],
      image: json['image'],
      rating: json['rating'],
      author: json['author'],
      publication: json['publication'],
      publishedDate: json['published_date'],
      reviewsCount: json['reviews_count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'slug': slug,
      'name': name,
      'category': category,
      'image': image,
      'rating': rating,
      'author': author,
      'publication': publication,
      'published_date': publishedDate,
      'reviews_count': reviewsCount,
    };
  }
}
