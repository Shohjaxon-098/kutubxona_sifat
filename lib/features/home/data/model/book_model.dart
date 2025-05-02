import 'package:kutubxona/features/home/domain/entities/book_entity.dart';

class BookModel extends BookEntity {
  BookModel({
    required int id,
    required String slug,
    required String name,
    required String category,
    required String image,
    String? rating, // Keep as String? to match BookEntity
    required String author,
    required String publication,
    String? publishedDate,
    String? reviewsCount, // Keep as String? to match BookEntity
  }) : super(
         id: id,
         slug: slug,
         name: name,
         category: category,
         image: image,
         rating: rating,
         author: author,
         publication: publication,
         publishedDate: publishedDate,
         reviewsCount: reviewsCount,
       );

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      id: json['id'],
      slug: json['slug'],
      name: json['name'],
      category: json['category'],
      image: json['image'],
      rating:
          json['rating']
              ?.toString(), // Convert to String if it's a double or int
      author: json['author'],
      publication: json['publication'],
      publishedDate: json['published_date'],
      reviewsCount:
          json['reviews_count']
              ?.toString(), // Convert to String if it's a number
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
