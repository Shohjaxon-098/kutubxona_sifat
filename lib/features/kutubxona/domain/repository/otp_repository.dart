import 'package:kutubxona/features/kutubxona/domain/entities/otp_entity.dart';

abstract class OtpRepository {
  Future<void> verifyOtp(OtpEntity otpEntity);
}