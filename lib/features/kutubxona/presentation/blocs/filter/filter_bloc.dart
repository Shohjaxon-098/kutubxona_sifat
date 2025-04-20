import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kutubxona/features/kutubxona/domain/entities/filter_entity.dart';
import 'package:kutubxona/features/kutubxona/domain/usecases/clear_filters_usecases.dart';
import 'package:kutubxona/features/kutubxona/presentation/blocs/filter/filter_event.dart';
import 'package:kutubxona/features/kutubxona/presentation/blocs/filter/filter_state.dart';


class FilterBloc extends Bloc<FilterEvent, FilterState> {
  final ClearFiltersUseCase clearFiltersUseCase;

  FilterBloc(this.clearFiltersUseCase)
      : super(const FilterState(filters: FilterEntity())) {
    on<SelectYearEvent>((event, emit) {
      emit(state.copyWith(
        filters: state.filters.copyWith(selectedYear: event.year),
      ));
    });

    on<ToggleRatingEvent>((event, emit) {
      final ratings = List<int>.from(state.filters.selectedRatings);
      if (ratings.contains(event.rating)) {
        ratings.remove(event.rating);
      } else {
        ratings.add(event.rating);
      }
      emit(state.copyWith(filters: state.filters.copyWith(selectedRatings: ratings)));
    });

    on<ClearFiltersEvent>((event, emit) {
      emit(FilterState(filters: clearFiltersUseCase()));
    });
  }
}
