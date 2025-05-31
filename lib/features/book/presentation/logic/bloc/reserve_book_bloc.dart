import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kutubxona/features/book/domain/entities/reserved_book_entity.dart';
import 'package:kutubxona/features/book/domain/usecase/reserve_book_usecase.dart';
part 'reserve_book_event.dart';
part 'reserve_book_state.dart';

class ReserveBookCubit extends Cubit<ReserveBookState> {
  final ReserveBookUseCase useCase;

  ReserveBookCubit(this.useCase) : super(ReserveBookInitial());

  Future<void> reserveBook(int bookId) async {
    emit(ReserveBookLoading());
    try {
      final result = await useCase(bookId);
      emit(ReserveBookSuccess(result));
    } catch (e) {
      emit(ReserveBookError(e.toString()));
    }
  }
}
