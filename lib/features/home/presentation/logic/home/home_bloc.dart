
import 'package:kutubxona/export.dart';

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

    final libraryId = await getLibraryId();

    if (libraryId.isEmpty) {
      emit(HomeError(message: "Library ID is missing"));
      return;
    }

    final categoriesResult = await getCategoriesUseCase(libraryId);
    final booksResult = await getBooksUseCase(
      categoryId: event.categoryId,

    );

    emit(HomeDataLoaded(
      categories: categoriesResult,
      books: booksResult,
    ));
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
