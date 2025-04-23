import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:kutubxona/core/error/failure.dart';
import 'package:kutubxona/features/kutubxona/data/datasources/media_remote_data_source.dart';
import 'package:kutubxona/features/kutubxona/domain/entities/upload_image_entity.dart';
import 'package:kutubxona/features/kutubxona/domain/repository/media_repository.dart';

class MediaRepositoryImpl implements MediaRepository {
  final MediaRemoteDataSource remoteDataSource;

  MediaRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, MediaUpload>> uploadMedia(File file, String type) async {
    try {
      final result = await remoteDataSource.uploadMedia(file, type);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
