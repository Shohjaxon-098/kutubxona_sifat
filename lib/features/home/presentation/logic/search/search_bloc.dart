import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kutubxona/features/home/domain/usecase/search_books_usecase.dart';
import 'package:kutubxona/features/home/presentation/logic/search/search_event.dart';
import 'package:kutubxona/features/home/presentation/logic/search/search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchBooksUseCase searchBooksUseCase;

  SearchBloc(this.searchBooksUseCase) : super(SearchInitial()) {
    on<SearchQueryChanged>((event, emit) async {
      emit(SearchLoading());
      try {
        final results = await searchBooksUseCase(event.query);

        // Filter qo‘llash
        final filteredResults =
            results.where((book) {
              final matchYear =
                  event.filters.selectedYear == null ||
                  book.publishedDate.toString() == event.filters.selectedYear;

              final matchRating =
                  event.filters.selectedRatings.isEmpty ||
                  event.filters.selectedRatings.contains(book.rating.toString());

              return matchYear && matchRating;
            }).toList();

        emit(SearchLoaded(filteredResults));
      } catch (e) {
        emit(SearchError("Qidirishda xatolik: $e"));
      }
    });
  }
}
