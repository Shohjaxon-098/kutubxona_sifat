import 'package:equatable/equatable.dart';
import 'package:kutubxona/features/book/domain/entities/review_request_entity.dart';

abstract class PostReviewEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SubmitReview extends PostReviewEvent {
  final ReviewRequestEntity review;

  SubmitReview(this.review);

  @override
  List<Object?> get props => [review];
}
