import 'package:kutubxona/export.dart';
import 'package:kutubxona/features/drawer/domain/usecases/get_deficient_book_usecase.dart';
import 'package:kutubxona/features/drawer/presentation/logic/cubit/deficient_book_state.dart';

class DeficientBooksCubit extends Cubit<DeficientBooksState> {
  final GetDeficientBooksUseCase getBooks;

  DeficientBooksCubit(this.getBooks) : super(DeficientBooksInitial());

  Future<void> fetchBooks() async {
    emit(DeficientBooksLoading());
    try {
      final books = await getBooks();
      emit(DeficientBooksLoaded(books));
    } catch (e) {
      emit(DeficientBooksError(e.toString()));
    }
  }
}
