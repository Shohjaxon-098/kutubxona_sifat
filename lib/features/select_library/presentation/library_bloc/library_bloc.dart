import 'package:kutubxona/export.dart';
import 'package:kutubxona/features/select_library/domain/usecase/get_libraries_usecase.dart';
import 'package:kutubxona/features/select_library/presentation/library_bloc/library_event.dart';
import 'package:kutubxona/features/select_library/presentation/library_bloc/library_state.dart';

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
