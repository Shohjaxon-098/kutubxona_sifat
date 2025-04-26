import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kutubxona/core/error/failure.dart';
import 'package:kutubxona/features/kutubxona/domain/usecases/upload_image_usecase.dart';

part 'upload_image_event.dart';
part 'upload_image_state.dart';

class UploadImageBloc extends Bloc<UploadImageEvent, UploadImageState> {
  final UploadImageUseCase uploadImageUseCase;

  UploadImageBloc({required this.uploadImageUseCase})
    : super(UploadImageInitial()) {
    on<StartUploadImage>(_onStartUpload);
  }

  Future<void> _onStartUpload(
    StartUploadImage event,
    Emitter<UploadImageState> emit,
  ) async {
    emit(UploadImageLoading());

    final result = await uploadImageUseCase(event.file);

    result.fold(
      (failure) => emit(UploadImageFailure(_mapFailureToMessage(failure))),
      (response) => emit(UploadImageSuccess(response.id, event.file)),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return failure.message;
    }
    return "Rasm yuklashda xatolik yuz berdi";
  }
}
