import 'package:kutubxona/core/util/important.dart';
import 'package:kutubxona/features/kutubxona/domain/repository/book_repository.dart';
import 'package:kutubxona/features/kutubxona/presentation/blocs/bloc/home_state.dart';

class HomeBloc extends Cubit<HomeState> {
  final BookRepository getBooks;

  HomeBloc({required this.getBooks}) : super(HomeInitial());

  Future<void> fetchCategories() async {
    emit(HomeLoading());
    try {
      final categories = await getBooks;
      emit(HomeLoaded(categories));
    } catch (e) {
      emit(HomeError("Kategoriya yuklab olishda xatolik"));
    }
  }
}