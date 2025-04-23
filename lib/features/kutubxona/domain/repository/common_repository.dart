import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:kutubxona/core/error/failure.dart';
import 'package:kutubxona/features/kutubxona/domain/entities/upload_image_response_entity.dart';

abstract class CommonRepository {
  Future<Either<Failure, UploadImageResponseEntity>> uploadImage({
    required File file,
  });
}
