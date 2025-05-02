// data/repositories/otp_repository_impl.dart
import 'package:kutubxona/features/auth/data/datasources/otp_remote_datasource.dart';
import 'package:kutubxona/features/auth/data/model/register_verify.dart';
import 'package:kutubxona/features/auth/domain/repository/otp_repository.dart';

import 'package:kutubxona/features/auth/domain/entities/otp_entity.dart';

class OtpRepositoryImpl implements OtpRepository {
  final OtpRemoteDataSource remoteDataSource;

  OtpRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> verifyOtp(OtpEntity otpEntity) {
    final model = OtpVerifyModel(
      phoneNumber: otpEntity.phoneNumber,
      libraryId: otpEntity.libraryId,
      otp: otpEntity.otp,
    );
    return remoteDataSource.verifyOtp(model);
  }
}
