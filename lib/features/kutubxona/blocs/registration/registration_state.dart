abstract class RegistrationState {}

class RegistrationInitial extends RegistrationState {}

class RegistrationLoading extends RegistrationState {}

class RegistrationSuccess extends RegistrationState {
  final dynamic response; // Yangi foydalanuvchi ma'lumotlari

  RegistrationSuccess(this.response);
}

class RegistrationFailure extends RegistrationState {
  final String error;

  RegistrationFailure(this.error);
}
