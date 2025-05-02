abstract class OtpEvent {}

class SubmitOtp extends OtpEvent {
  final String phoneNumber;
  final String libraryId;
  final int otp;

  SubmitOtp({
    required this.phoneNumber,
    required this.libraryId,
    required this.otp,
  });
}