import 'package:kutubxona/features/auth/domain/entities/otp_entity.dart';

abstract class OtpRepository {
  Future<void> verifyOtp(OtpEntity otpEntity);
}