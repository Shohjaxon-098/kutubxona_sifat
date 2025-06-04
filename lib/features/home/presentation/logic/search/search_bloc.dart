import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kutubxona/features/home/domain/usecase/search_books_usecase.dart';
import 'package:kutubxona/features/home/presentation/logic/search/search_event.dart';
import 'package:kutubxona/features/home/presentation/logic/search/search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchBooksUseCase searchBooksUseCase;

  SearchBloc(this.searchBooksUseCase) : super(SearchInitial()) {
    on<SearchQueryChanged>((event, emit) async {
      emit(SearchLoading(event.query));
      try {
        final results = await searchBooksUseCase(event.query);

        final filteredResults =
            results.where((book) {
              final publishedYear =
                  book.publishedDate != null
                      ? DateTime.tryParse(book.publishedDate.toString())?.year
                      : null;

              final matchYear =
                  event.filters.selectedYear == null ||
                  event.filters.selectedYear == publishedYear;

              final bookRating = book.rating ?? 0;
              final matchRating =
                  event.filters.selectedRatings.isEmpty ||
                  event.filters.selectedRatings.contains(bookRating);

              return matchYear && matchRating;
            }).toList();

        emit(SearchLoaded(filteredResults, event.query));
      } catch (e) {
        emit(SearchError("Qidirishda xatolik: $e", event.query));
      }
    });
  }
}
