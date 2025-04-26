import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kutubxona/features/kutubxona/domain/usecases/get_books_usecase.dart';
import 'package:kutubxona/features/kutubxona/domain/usecases/get_categories_usecase.dart';
import 'home_event.dart';
import 'home_state.dart';


class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetCategoriesUseCase getCategoriesUseCase;
  final GetBooksUseCase getBooksUseCase;

  HomeBloc({
    required this.getCategoriesUseCase,
    required this.getBooksUseCase,
  }) : super(HomeInitial()) {
    on<LoadHomeData>((event, emit) async {
      emit(HomeLoading());
      try {
        final categories = await getCategoriesUseCase();
        final books = await getBooksUseCase();
        emit(HomeLoaded(categories: categories, books: books));
      } catch (e) {
        emit(HomeError(e.toString()));
      }
    });
  }
}
