
abstract class ReviewEvent {}

class FetchReviews extends ReviewEvent {
  final String libraryId;
  final String slug;
  final int limit;
  final int offset;

  FetchReviews({
    required this.libraryId,
    required this.slug,
    this.limit = 10,
    this.offset = 0,
  });
}
