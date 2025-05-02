abstract class RegisterStep1Event {}

class SubmitPhoneNumber extends RegisterStep1Event {
  final String phoneNumber;
  final String libraryId;

  SubmitPhoneNumber({
    required this.phoneNumber,
    required this.libraryId,
  });
}
