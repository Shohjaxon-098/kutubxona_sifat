abstract class Failure {
  final String message;
  Failure({required this.message});
}

class ServerFailure extends Failure {
  ServerFailure({required String message}) : super(message: message);
}

class NetworkFailure extends Failure {
  NetworkFailure() : super(message:  'Internet aloqasi mavjud emas');
}
