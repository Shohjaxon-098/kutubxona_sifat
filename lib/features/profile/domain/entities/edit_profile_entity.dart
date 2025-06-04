class EditProfileEntity {
  final String? firstName;
  final String? lastName;
  final String gender;
  final String? telegramUsername;
  final String? birthDate;
  final String? documentNumber;
  final int? documentFile1;
  final int? documentFile2;
  final int? photo;
  final String? verificationType;
  final String password;

  EditProfileEntity({
    required this.firstName,
    required this.lastName,
    required this.gender,
    this.telegramUsername,
    this.birthDate,
    this.documentNumber,
    this.documentFile1,
    this.documentFile2,
    this.photo,
    this.verificationType,
    required this.password,
  });
}
