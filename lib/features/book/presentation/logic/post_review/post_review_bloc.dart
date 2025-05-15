import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kutubxona/features/book/domain/usecase/post_review_usecase.dart';
import 'post_review_event.dart';
import 'post_review_state.dart';
class PostReviewBloc extends Bloc<PostReviewEvent, PostReviewState> {
  final PostReviewUseCase useCase;

  PostReviewBloc(this.useCase) : super(PostReviewInitial()) {
    on<SubmitReview>(_onSubmitReview);
  }

  Future<void> _onSubmitReview(
    SubmitReview event,
    Emitter<PostReviewState> emit,
  ) async {
    emit(PostReviewLoading());
    try {
      await useCase(event.review); // faqat 1 marta chaqiriladi
      emit(PostReviewSuccess());
    } catch (e) {
      emit(PostReviewError(e.toString()));
    }
  }
}
