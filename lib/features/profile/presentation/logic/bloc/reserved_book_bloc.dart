import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kutubxona/features/profile/domain/entities/reserved_book_entity.dart';
import 'package:kutubxona/features/profile/domain/usecases/get_reserved_books_usecase.dart';


part 'reserved_book_event.dart';
part 'reserved_book_state.dart';

class ReservedBookBloc extends Bloc<ReservedBookEvent, ReservedBookState> {
  final GetReservedBooksUseCase getReservedBooksUseCase;

  ReservedBookBloc(this.getReservedBooksUseCase)
    : super(ReservedBookInitial()) {
    on<LoadReservedBooks>((event, emit) async {
      emit(ReservedBookLoading());
      try {
        final books = await getReservedBooksUseCase(event.libraryId);
        emit(ReservedBookLoaded(books));
      } catch (e) {
        emit(ReservedBookError(e.toString()));
      }
    });
  }
}
