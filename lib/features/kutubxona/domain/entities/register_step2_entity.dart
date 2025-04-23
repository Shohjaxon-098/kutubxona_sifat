import 'package:kutubxona/core/util/important.dart';

class RegisterStep2Entity {
  final String firstName;
  final String lastName;
  final String selectGender;
  final String password;
  final String telegramId;
  final String birthDate;
  final String documentType;
  final String documentNumber;
  final String libraryId;
  final int userId;
  final File? documentFront;
  final File? documentBack;

  RegisterStep2Entity({
    required this.firstName,
    required this.lastName,
    required this.selectGender,
    required this.password,
    required this.telegramId,
    required this.birthDate,
    required this.documentType,
    required this.documentNumber,
    required this.libraryId,
    required this.userId,
    this.documentFront,
    this.documentBack,
  });

  RegisterStep2Entity copyWith({
    File? documentFront,
    File? documentBack,
  }) {
    return RegisterStep2Entity(
      firstName: firstName,
      lastName: lastName,
      selectGender: selectGender,
      password: password,
      telegramId: telegramId,
      birthDate: birthDate,
      documentType: documentType,
      documentNumber: documentNumber,
      libraryId: libraryId,
      userId: userId,
      documentFront: documentFront ?? this.documentFront,
      documentBack: documentBack ?? this.documentBack,
    );
  }
}
