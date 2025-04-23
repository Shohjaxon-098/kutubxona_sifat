import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:kutubxona/core/error/failure.dart';
import 'package:kutubxona/features/kutubxona/domain/entities/upload_image_response_entity.dart';
import 'package:kutubxona/features/kutubxona/domain/repository/common_repository.dart';

class UploadImageUseCase {
  final CommonRepository repository;
  UploadImageUseCase(this.repository);

  Future<Either<Failure, UploadImageResponseEntity>> call(File file) {
    return repository.uploadImage(file: file);
  }
}
