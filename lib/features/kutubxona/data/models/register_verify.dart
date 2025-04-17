import 'package:kutubxona/features/kutubxona/domain/entities/otp_entity.dart';

class OtpVerifyModel extends OtpEntity {
  OtpVerifyModel({
    required super.phoneNumber,
    required super.libraryId,
    required super.otp,
  });

  Map<String, dynamic> toJson() {
    return {
      "phone_number": phoneNumber,
      "library_id": libraryId,
      "otp_code": otp,
    };
  }
}
