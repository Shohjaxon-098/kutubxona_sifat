import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kutubxona/features/kutubxona/domain/usecases/search_books_usecase.dart';
import 'package:kutubxona/features/kutubxona/presentation/blocs/search/search_event.dart';
import 'package:kutubxona/features/kutubxona/presentation/blocs/search/search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchBooksUseCase searchBooksUseCase;

  SearchBloc(this.searchBooksUseCase) : super(SearchInitial()) {
    on<SearchQueryChanged>(_onSearchBooks);
  }

  Future<void> _onSearchBooks(
    SearchQueryChanged event,
    Emitter<SearchState> emit,
  ) async {
    try {
      emit(SearchLoading());

      final result = await searchBooksUseCase(
        event.query,
      ); // query bilan qidirish

      emit(SearchLoaded(result));
    } catch (e) {
      emit(SearchError(e.toString()));
    }
  }
}
