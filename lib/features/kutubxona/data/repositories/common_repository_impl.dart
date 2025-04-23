import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:kutubxona/core/error/failure.dart';
import 'package:kutubxona/features/kutubxona/data/datasources/common_remote_data_source.dart';
import 'package:kutubxona/features/kutubxona/domain/entities/upload_image_response_entity.dart';
import 'package:kutubxona/features/kutubxona/domain/repository/common_repository.dart';

class CommonRepositoryImpl implements CommonRepository {
  final CommonRemoteDataSource remoteDataSource;
  CommonRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, UploadImageResponseEntity>> uploadImage({
    required File file,
  }) async {
    try {
      final result = await remoteDataSource.uploadImage(file);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure( e.toString()));
    }
  }
}
