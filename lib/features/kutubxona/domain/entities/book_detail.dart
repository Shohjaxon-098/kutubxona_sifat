class BookDetail {
  final int id;
  final String name;
  final String slug;
  final String author;
  final String category;
  final String image;
  final String description;
  final String isbn;
  final String publication;
  final String publishedDate;
  final String language;
  final int pageCount;
  final int bookedCount;
  final String rating;         // ✅ double emas, endi String
  final String reviewsCount;   // ✅ int emas, endi String
  final String relatedBooks;

  BookDetail({
    required this.id,
    required this.name,
    required this.slug,
    required this.author,
    required this.category,
    required this.image,
    required this.description,
    required this.isbn,
    required this.publication,
    required this.publishedDate,
    required this.language,
    required this.pageCount,
    required this.bookedCount,
    required this.rating,
    required this.reviewsCount,
    required this.relatedBooks,
  });
}
