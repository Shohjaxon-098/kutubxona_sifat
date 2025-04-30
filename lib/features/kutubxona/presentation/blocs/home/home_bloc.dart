
import 'package:kutubxona/core/constants/important.dart';

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
    try {
      emit(HomeLoading());

      // Local storage'dan library_id olish
      String libraryId =
          await getLibraryId(); // Bu yerda getLibraryId() ni chaqiring

      if (libraryId.isEmpty) {
        emit(HomeError(message: "Library ID is missing"));
        return;
      }

      // Get Categories va Get Books ma'lumotlarini olish
      final categoriesResult = await getCategoriesUseCase(libraryId);
      final booksResult = await getBooksUseCase();

      // Ma'lumotlar muvaffaqiyatli olinganidan keyin
      emit(HomeDataLoaded(categories: categoriesResult, books: booksResult));
    } catch (e) {
      emit(HomeError(message: e.toString()));
    }
  }

  // Local storage'dan 'library_id'ni olish
  Future<String> getLibraryId() async {
    // Local storage'dan 'library_id' olish
    // Agar Hive yoki SharedPreferences ishlatayotgan bo'lsangiz, shu yerda tegishli kodni yozishingiz kerak
    return AppConfig.libraryId!; // Misol uchun, statik 'library_id'
  }
}
