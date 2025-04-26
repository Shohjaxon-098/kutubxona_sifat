import 'package:kutubxona/core/util/important.dart';
import 'package:kutubxona/features/kutubxona/domain/usecases/get_books_usecase.dart';
import 'package:kutubxona/features/kutubxona/domain/usecases/get_categories_usecase.dart';
import 'package:kutubxona/features/kutubxona/domain/usecases/search_books_usecase.dart';
import 'package:kutubxona/features/kutubxona/presentation/blocs/home/home_event.dart';
import 'package:kutubxona/features/kutubxona/presentation/blocs/home/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetBooksUseCase getBooksUseCase;
  final GetCategoriesUseCase getCategoriesUseCase;
  final SearchBooksUseCase searchBooksUseCase;

  HomeBloc({
    required this.getBooksUseCase,
    required this.getCategoriesUseCase,
    required this.searchBooksUseCase,
  }) : super(HomeInitial()) {
    on<GetAllHomeDataEvent>(_onGetAllHomeData);
    on<SearchBooksEvent>(_onSearchBooks);
  }

  Future<void> _onGetAllHomeData(
    GetAllHomeDataEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());
  }

  Future<void> _onSearchBooks(
    SearchBooksEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());

    final result = await searchBooksUseCase(event.query);

    result.fold(
      (failure) => emit(HomeError(failure.message)),
      (books) => emit(
        HomeLoaded(books: books, categories: []),
      ), // Categories not needed for search
    );
  }
}
