import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kutubxona/features/book/domain/repository/review_repository.dart';
import 'package:kutubxona/features/book/presentation/logic/book_review/book_reviews_event.dart';
import 'package:kutubxona/features/book/presentation/logic/book_review/book_reviews_state.dart';

/// ReviewBloc - kitob sharhlarini olish uchun BLoC
class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  final ReviewRepository repository;

  /// Constructor: boshlang‘ich holat ReviewInitial bilan boshlanadi
  ReviewBloc(this.repository) : super(ReviewInitial()) {
    // FetchReviews eventi kelganda ishlovchi handler
    on<FetchReviews>((event, emit) async {
      emit(ReviewLoading()); // Yuklanmoqda holatini chiqarish

      try {
        // Repository orqali sharhlar ro'yxatini olish
        final reviews = await repository.getReviews(
          libraryId: event.libraryId,
          slug: event.slug,
        );

        emit(ReviewLoaded(reviews)); // Sharhlar muvaffaqiyatli yuklandi
      } catch (e) {
        emit(ReviewError(e.toString())); // Xatolik yuz berdi
      }
    });
  }
}
