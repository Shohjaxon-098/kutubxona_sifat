// domain/usecases/verify_otp_usecase.dart
import 'package:kutubxona/features/auth/domain/repository/otp_repository.dart';

import 'package:kutubxona/features/auth/domain/entities/otp_entity.dart';

class VerifyOtpUseCase {
  final OtpRepository repository;

  VerifyOtpUseCase(this.repository);

  Future<void> call(OtpEntity entity) {
    return repository.verifyOtp(entity);
  }
}
