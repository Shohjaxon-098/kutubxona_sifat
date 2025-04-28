import 'package:kutubxona/core/constants/important.dart';
import 'package:kutubxona/features/kutubxona/domain/usecases/get_books_usecase.dart';
import 'package:kutubxona/features/kutubxona/domain/usecases/get_categories_usecase.dart';
import 'package:kutubxona/features/kutubxona/presentation/blocs/home/home_event.dart';
import 'package:kutubxona/features/kutubxona/presentation/blocs/home/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetBooksUseCase getBooksUseCase;
  final GetCategoriesUseCase getCategoriesUseCase;

  HomeBloc({
    required this.getBooksUseCase,
    required this.getCategoriesUseCase,

  }) : super(HomeInitial()) {
    on<GetAllHomeDataEvent>(_onGetAllHomeData);
  }

  Future<void> _onGetAllHomeData(
    GetAllHomeDataEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());
  }


}
