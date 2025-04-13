import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kutubxona/features/kutubxona/data/models/book.dart';
import 'package:kutubxona/features/kutubxona/enums/filter_type.dart';
import 'package:kutubxona/features/kutubxona/presentation/home/logic/bloc/book_search_event.dart';
import 'package:kutubxona/features/kutubxona/presentation/home/logic/bloc/book_search_state.dart';

class BookSearchBloc extends Bloc<BookSearchEvent, BookSearchState> {
  final List<Book> books; // offline data

  BookSearchBloc(this.books) : super(BookSearchInitial()) {
    on<SearchBooks>((event, emit) async {
       final query = event.query.trim();

  if (query.isEmpty) {
    emit(BookSearchInitial()); // hech nima ko‘rsatmaymiz
    return;
  }
      emit(BookSearchLoading());

      await Future.delayed(const Duration(milliseconds: 300)); // imitate loading

      List<Book> filtered = books.where((book) {
    final name = book.name.toLowerCase();
    final input = query.toLowerCase();

    return name.split(" ").first.startsWith(input); // faqat boshidan boshlab mos bo‘lsa
  }).toList();

      if (event.filter == FilterType.byYear) {
        filtered.sort((a, b) => b.year.compareTo(a.year)); // yangi yili oldinda
      } else if (event.filter == FilterType.byRating) {
        filtered.sort((a, b) => b.rate.compareTo(a.rate));
      }

      emit(BookSearchLoaded(filtered));
    });
  }
}
