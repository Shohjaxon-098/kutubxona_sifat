
import 'dart:io';

class RegisterStep2Entity {
  final String firstName;
  final String lastName;
  final String password;
  final String telegramId;
  final String birthDate;
  final String documentType;
  final String documentNumber;
  final File documentFile1;
  final File documentFile2;

  RegisterStep2Entity({
    required this.firstName,
    required this.lastName,
    required this.password,
    required this.telegramId,
    required this.birthDate,
    required this.documentType,
    required this.documentNumber,
    required this.documentFile1,
    required this.documentFile2,
  });
}
