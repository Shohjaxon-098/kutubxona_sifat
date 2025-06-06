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

        emit(SearchLoaded(results));
      } catch (e) {
        emit(SearchError("Qidirishda xatolik: $e", event.query));
      }
    });
  }
}
