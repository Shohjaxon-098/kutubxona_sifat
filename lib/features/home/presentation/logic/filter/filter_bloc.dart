import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kutubxona/features/home/domain/entities/book_entity.dart';
import 'package:kutubxona/features/home/domain/entities/filter_entity.dart';
import 'package:kutubxona/features/home/domain/usecase/clear_filters_usecases.dart';
import 'package:kutubxona/features/home/presentation/logic/filter/filter_event.dart';
import 'package:kutubxona/features/home/presentation/logic/filter/filter_state.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  final ClearFiltersUseCase clearFiltersUseCase;

  FilterBloc(this.clearFiltersUseCase)
    : super(const FilterState(filters: FilterEntity())) {
    on<SelectYearEvent>((event, emit) {
      emit(
        state.copyWith(
          filters: state.filters.copyWith(selectedYear: event.year),
        ),
      );
    });

    on<ToggleRatingEvent>((event, emit) {
      final ratings = List<int>.from(state.filters.selectedRatings);
      if (ratings.contains(event.rating)) {
        ratings.remove(event.rating);
      } else {
        ratings.add(event.rating);
      }
      emit(
        state.copyWith(
          filters: state.filters.copyWith(selectedRatings: ratings),
        ),
      );
    });

    on<ClearFiltersEvent>((event, emit) {
      emit(FilterState(filters: clearFiltersUseCase()));
    });
    on<ApplyFiltersEvent>((event, emit) {
      List<BookEntity> _applyFiltersToBooks(
        List<BookEntity> books,
        FilterEntity filters,
      ) {
        return books.where((book) {
          final matchYear =
              filters.selectedYear == null ||
              book.publication.toString() == filters.selectedYear;
          final matchRating =
              filters.selectedRatings.isEmpty ||
              filters.selectedRatings.contains(book.rating.toString());
          return matchYear && matchRating;
        }).toList();
      }

      // You need to provide the list of books here. Replace `allBooks` with your actual list.
      final List<BookEntity> allBooks =
          []; // TODO: Replace with actual books source
      final filteredBooks = _applyFiltersToBooks(allBooks, state.filters);
      emit(state.copyWith(filters: filteredBooks as FilterEntity));
    });
  }
}
