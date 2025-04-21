import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kutubxona/features/kutubxona/domain/usecases/searchs_book_usecases.dart';
import 'search_event.dart';
import 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchBooks searchBooks;

  SearchBloc(this.searchBooks) : super(SearchInitial()) {
    on<SearchQueryChanged>((event, emit) async {
      if (event.query.isEmpty) return emit(SearchInitial());

      emit(SearchLoading());
      try {
        final books = await searchBooks(event.query);
        emit(SearchLoaded(books));
      } catch (e) {
        emit(SearchError('Xatolik yuz berdi'));
      }
    });
  }
}
