import 'package:kutubxona/export.dart';
import 'package:kutubxona/features/category/presentation/logic/bloc/category_event.dart';
import 'package:kutubxona/features/category/presentation/logic/bloc/category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final GetBooksUseCase getBooksByCategoryUseCase;

  CategoryBloc(this.getBooksByCategoryUseCase) : super(CategoryInitial()) {
    on<GetBooksByCategoryEvent>(_onGetBooksByCategory);
  }

  Future<void> _onGetBooksByCategory(
    GetBooksByCategoryEvent event,
    Emitter<CategoryState> emit,
  ) async {
    try {
      emit(CategoryLoadingState());
      final result = await getBooksByCategoryUseCase(
        categoryId: event.categoryId,
        searchQuery: event.searchQuery,
        ratings: event.rating,
        year: event.year
      );
      emit(CategoryLoadedState(result));
    } catch (e) {
      emit(CategoryErrorState(e.toString()));
    }
  }
}
