import 'package:kutubxona/features/book/domain/entities/book_detail.dart';

class BookDetailModel extends BookDetail {
  BookDetailModel({
    required super.id,
    required super.name,
    required super.slug,
    required super.author,
    required super.category,
    required super.image,
    required super.description,
    required super.isbn,
    required super.publication,
    required super.publishedDate,
    required super.language,
    required super.pageCount,
    required super.bookedCount,
    required super.rating,
    required super.reviewsCount,
    required super.relatedBooks,
  });

  factory BookDetailModel.fromJson(Map<String, dynamic> json) {
    return BookDetailModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
      author: json['author'] ?? '',
      category: json['category'] ?? '',
      image: json['image'] ?? '',
      description: json['description'] ?? '',
      isbn: json['isbn'] ?? '',
      publication: json['publication'] ?? '',
      publishedDate: json['published_date'] ?? '',
      language: json['language'] ?? '',
      pageCount: json['page_count'] ?? 0,
      bookedCount: json['booked_count'] ?? 0,
      rating: json['rating']?.toString() ?? '0', // safe string conversion
      reviewsCount:
          json['reviews_count']?.toString() ?? '0', // safe string conversion
      relatedBooks:
          json['related_books'] != null
              ? (json['related_books'] is List
                  ? json['related_books'].join(
                    ', ',
                  ) // Assuming related books are a List
                  : json['related_books'].toString())
              : '', // Fallback to empty string if null
    );
  }
}
