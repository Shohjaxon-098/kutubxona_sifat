import 'package:bloc/bloc.dart';
import 'package:kutubxona/features/book/data/datasources/book_reserve_remote_data_source.dart';

import 'package:kutubxona/features/book/presentation/logic/bloc/reserve_book_event.dart';
import 'package:kutubxona/features/book/presentation/logic/bloc/reserve_book_state.dart';

class ReserveBookBloc extends Bloc<ReserveBookEvent, ReserveBookState> {
  final BookReserveRemoteDataSource dataSource;

  ReserveBookBloc(this.dataSource) : super(ReserveBookInitial()) {
    on<ReserveBookRequested>(_onReserveBook);
    on<CancelReservationRequested>(_onCancelReservation);
  }

  Future<void> _onReserveBook(
    ReserveBookRequested event,
    Emitter<ReserveBookState> emit,
  ) async {
    emit(ReserveBookLoading());
    try {
      final result = await dataSource.reserveBook(event.bookId);
      emit(ReserveBookSuccess(result));
    } catch (e) {
      emit(ReserveBookError(e.toString()));
    }
  }

  Future<void> _onCancelReservation(
    CancelReservationRequested event,
    Emitter<ReserveBookState> emit,
  ) async {
    emit(ReserveBookLoading());
    try {
      await dataSource.cancelReservation(event.reservationId!);
      emit(CancelReservationSuccess());
    } catch (e) {
      emit(ReserveBookError(e.toString()));
    }
  }
}
