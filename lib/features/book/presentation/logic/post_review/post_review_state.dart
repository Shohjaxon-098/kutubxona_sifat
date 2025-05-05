abstract class PostReviewState {}

class PostReviewInitial extends PostReviewState {}

class PostReviewLoading extends PostReviewState {}

class PostReviewSuccess extends PostReviewState {}

class PostReviewError extends PostReviewState {
  final String message;
  PostReviewError(this.message);
}
