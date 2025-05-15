import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kutubxona/features/book/domain/entities/book_detail.dart';
import 'package:kutubxona/features/book/domain/usecase/get_book_detail.dart';

import 'book_detail_event.dart';
import 'book_detail_state.dart';

class BookDetailBloc extends Bloc<BookDetailEvent, BookDetailState> {
  final GetBookDetail getBookDetail;
  final Map<String, BookDetail> _cache = {};

  BookDetailBloc(this.getBookDetail) : super(BookDetailInitial()) {
    on<FetchBookDetail>((event, emit) async {
      // Agar bu slug allaqachon cache’da bo‘lsa, to‘g‘ridan-to‘g‘ri qaytaramiz
      if (_cache.containsKey(event.slug)) {
        emit(BookDetailLoaded(_cache[event.slug]!));
        return;
      }

      emit(BookDetailLoading()); // Faqat birinchi marta yuklanadi
      try {
        final book = await getBookDetail(event.libraryId, event.slug);
        _cache[event.slug] = book; // Cache saqlash
        emit(BookDetailLoaded(book));
      } catch (e) {
        emit(BookDetailError("Xatolik yuz berdi: ${e.toString()}"));
      }
    });
  }
}
