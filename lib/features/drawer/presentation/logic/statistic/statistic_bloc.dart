import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kutubxona/features/drawer/domain/usecases/get_statistik_usecase.dart';
import 'statistic_event.dart';
import 'statistic_state.dart';

class StatisticBloc extends Bloc<StatisticEvent, StatisticState> {
  final GetStatisticsUseCase useCase;

  StatisticBloc(this.useCase) : super(StatisticInitial()) {
    on<LoadStatistics>((event, emit) async {
      emit(StatisticLoading());
      try {
        final statistic = await useCase(event.libraryId);
        emit(StatisticLoaded(statistic));
      } catch (e) {
        emit(StatisticError(e.toString()));
      }
    });
  }
}
