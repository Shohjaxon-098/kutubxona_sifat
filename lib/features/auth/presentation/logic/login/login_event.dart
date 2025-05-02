// login_event.dart

abstract class LoginEvent {}

class LoginButtonPressed extends LoginEvent {
  final String phoneNumber;
  final String password;
  final String libraryId;

  LoginButtonPressed({
    required this.phoneNumber,
    required this.password,
    required this.libraryId,
  });
}
