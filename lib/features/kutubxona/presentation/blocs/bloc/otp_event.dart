abstract class OtpEvent {}

class SubmitOtp extends OtpEvent {
  final String phoneNumber;
  final String libraryId;
  final String otp;

  SubmitOtp({
    required this.phoneNumber,
    required this.libraryId,
    required this.otp,
  });
}