abstract class RegistrationEvent {}

class RegisterUserEvent extends RegistrationEvent {
  final Map<String, dynamic> userData;

  RegisterUserEvent(this.userData);
}
