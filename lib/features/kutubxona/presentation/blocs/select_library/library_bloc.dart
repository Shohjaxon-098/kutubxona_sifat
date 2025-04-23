import 'package:kutubxona/core/util/important.dart';
import 'package:kutubxona/features/kutubxona/domain/usecases/get_libraries_usecase.dart';

class LibraryBloc extends Bloc<LibraryEvent, LibraryState> {
  final GetLibrariesUseCase getLibrariesUseCase;

  LibraryBloc(this.getLibrariesUseCase) : super(LibraryInitial()) {
    on<FetchLibrariesEvent>((event, emit) async {
      emit(LibraryLoading());
      try {
        final libraries = await getLibrariesUseCase();
        emit(LibraryLoaded(libraries));
      } catch (e) {
        emit(LibraryError(e.toString()));
      }
    });
  }
}
