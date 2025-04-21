class BookEntity {
  final int id;
  final String slug;
  final String name;
  final String category;
  final String image;
  final String? rating;
  final String author;
  final String publication;
  final String? publishedDate;
  final int? reviewsCount;

  BookEntity({
    required this.id,
    required this.slug,
    required this.name,
    required this.category,
    required this.image,
    this.rating,
    required this.author,
    required this.publication,
    this.publishedDate,
    this.reviewsCount,
  });
}
