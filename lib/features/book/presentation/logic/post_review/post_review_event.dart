import 'package:equatable/equatable.dart';
import 'package:kutubxona/features/book/domain/entities/review_request_entity.dart';
import 'package:kutubxona/features/book/presentation/logic/book_get_review/book_reviews_bloc.dart';

abstract class PostReviewEvent extends Equatable {
  @override
  List<Object?> get props => [];
}
// review_event.dart


class SubmitReview extends PostReviewEvent {
  final ReviewRequestEntity review;
  final ReviewBloc reviewBloc; // yangi qo‘shildi

  SubmitReview({required this.review, required this.reviewBloc});
}

