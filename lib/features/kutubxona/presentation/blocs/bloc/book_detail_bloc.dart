import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kutubxona/features/kutubxona/domain/usecases/get_book_detail.dart';

import 'book_detail_event.dart';
import 'book_detail_state.dart';

class BookDetailBloc extends Bloc<BookDetailEvent, BookDetailState> {
  final GetBookDetail getBookDetail;

  BookDetailBloc(this.getBookDetail) : super(BookDetailInitial()) {
    on<FetchBookDetail>((event, emit) async {
      emit(BookDetailLoading());
      try {
        final book = await getBookDetail(event.libraryId, event.slug);
        emit(BookDetailLoaded(book));
      } catch (e) {
        emit(BookDetailError("Xatolik yuz berdi: ${e.toString()}"));
      }
    });
  }
}
