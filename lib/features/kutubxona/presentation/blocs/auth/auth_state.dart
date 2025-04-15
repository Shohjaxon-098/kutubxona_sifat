abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final dynamic response; // Yangi foydalanuvchi ma'lumotlari

  AuthSuccess(this.response);
}

class AuthFailure extends AuthState {
  final String error;

  AuthFailure(this.error);
}
