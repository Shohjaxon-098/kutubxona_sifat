import '../../domain/entities/book_entity.dart';

class BookModel extends BookEntity {
  BookModel({
    required int id,
    required String slug,
    required String name,
    required String category,
    required String image,
    double? rating,
    required String author,
    required String publication,
    String? publishedDate,
    int? reviewsCount,
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
      rating: (json['rating'] is int) ? (json['rating'] as int).toDouble() : json['rating'],
      author: json['author'],
      publication: json['publication'],
      publishedDate: json['published_date'],
      reviewsCount: json['reviews_count'],
    );
  }

  Map<String, dynamic> toJson() => {
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
