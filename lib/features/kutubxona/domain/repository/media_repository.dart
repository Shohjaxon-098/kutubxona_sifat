import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:kutubxona/core/error/failure.dart';
import 'package:kutubxona/features/kutubxona/domain/entities/upload_image_entity.dart';

abstract class MediaRepository {
  Future<Either<Failure, MediaUpload>> uploadMedia(File file, String type);
}
