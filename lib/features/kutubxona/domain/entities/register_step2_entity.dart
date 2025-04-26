class RegisterStep2Entity {
  final String firstName;
  final String lastName;
  final String selectGender;
  final String password;
  final String telegramUsername;
  final String birthDate;
  final String documentType;
  final String documentNumber;
  final String libraryId;
  final int userId;
  final int? documentFront;
  final int? documentBack;

  RegisterStep2Entity({
    required this.firstName,
    required this.lastName,
    required this.selectGender,
    required this.password,
    required this.telegramUsername,
    required this.birthDate,
    required this.documentType,
    required this.documentNumber,
    required this.libraryId,
    required this.userId,
    this.documentFront,
    this.documentBack,
  });

  RegisterStep2Entity copyWith() {
    return RegisterStep2Entity(
      firstName: firstName,
      lastName: lastName,
      selectGender: selectGender,
      password: password,
      telegramUsername: telegramUsername,
      birthDate: birthDate,
      documentType: documentType,
      documentNumber: documentNumber,
      libraryId: libraryId,
      userId: userId,
      documentFront: documentFront,
      documentBack: documentBack,
    );
  }
}
