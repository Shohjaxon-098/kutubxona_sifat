abstract class BookDetailEvent {}

class FetchBookDetail extends BookDetailEvent {
  final String libraryId;
    final String slug;

  FetchBookDetail(this.libraryId,this.slug);
}
