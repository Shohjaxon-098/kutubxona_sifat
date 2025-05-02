import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kutubxona/features/book/domain/repository/review_repository.dart';
import 'package:kutubxona/features/book/presentation/logic/bloc/book_reviews_event.dart';
import 'package:kutubxona/features/book/presentation/logic/bloc/book_reviews_state.dart';


class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  final ReviewRepository repository;

  ReviewBloc(this.repository) : super(ReviewInitial()) {
    on<FetchReviews>((event, emit) async {
      emit(ReviewLoading());
      try {
        final reviews = await repository.getReviews(
          libraryId: event.libraryId,
          slug: event.slug,
        
        );
        emit(ReviewLoaded(reviews));
      } catch (e) {
        emit(ReviewError(e.toString()));
      }
    });
  }
}
