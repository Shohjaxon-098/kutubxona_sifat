abstract class RegisterStep1State {}

class RegisterInitial extends RegisterStep1State {}

class RegisterLoading extends RegisterStep1State {}

class RegisterSuccess extends RegisterStep1State {}

class RegisterFailure extends RegisterStep1State {
  final String message;

  RegisterFailure(this.message);
}
