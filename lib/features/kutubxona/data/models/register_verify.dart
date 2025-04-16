import 'package:kutubxona/features/kutubxona/domain/entities/otp_entity.dart';

class OtpVerifyModel extends OtpEntity {
  OtpVerifyModel({
    required String phoneNumber,
    required String libraryId,
    required String otp,
  }) : super(phoneNumber: phoneNumber, libraryId: libraryId, otp: otp);

  Map<String, dynamic> toJson() {
    return {
      "phone_number": phoneNumber,
      "library_id": libraryId,
      "otp": otp,
    };
  }
}
