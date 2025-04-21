import 'package:kutubxona/core/util/important.dart';
import 'package:kutubxona/features/kutubxona/domain/usecases/get_categories.dart';
import 'package:kutubxona/features/kutubxona/presentation/blocs/category/category_state.dart';

class CategoryBloc extends Cubit<CategoryState> {
  final GetCategories getCategories;

  CategoryBloc({required this.getCategories}) : super(CategoryInitial());

  Future<void> fetchCategories() async {
    emit(CategoryLoading());
    try {
      final categories = await getCategories();
      emit(CategoryLoaded(categories));
    } catch (e) {
      emit(CategoryError("Kategoriya olishda xatolik"));
    }
  }
}
