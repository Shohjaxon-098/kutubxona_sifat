import 'package:kutubxona/core/util/important.dart';
import 'package:kutubxona/features/kutubxona/domain/usecases/upload_image_usecase.dart';
import 'package:kutubxona/features/kutubxona/presentation/blocs/bloc/upload_image_event.dart';
import 'package:kutubxona/features/kutubxona/presentation/blocs/bloc/upload_image_state.dart';

class UploadMediaBloc extends Bloc<UploadMediaEvent, UploadMediaState> {
  final UploadMediaUseCase useCase;

  UploadMediaBloc(this.useCase) : super(UploadMediaInitial()) {
    on<UploadMediaStarted>((event, emit) async {
      emit(UploadMediaLoading());
      final result = await useCase(event.file, event.type);
      result.fold(
        (failure) => emit(UploadMediaFailure("Failed to upload file")),
        (media) => emit(UploadMediaSuccess(media)),
      );
    });
  }
}
