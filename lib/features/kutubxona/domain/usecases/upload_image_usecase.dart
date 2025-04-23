import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:kutubxona/core/error/failure.dart';
import 'package:kutubxona/features/kutubxona/domain/entities/upload_image_entity.dart';
import 'package:kutubxona/features/kutubxona/domain/repository/media_repository.dart';

class UploadMediaUseCase {
  final MediaRepository repository;

  UploadMediaUseCase(this.repository);

  Future<Either<Failure, MediaUpload>> call(File file, String type) {
    return repository.uploadMedia(file, type);
  }
}

