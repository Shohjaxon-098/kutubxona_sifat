class UserProfileEntity {
  final String firstName;
  final String lastName;
  final String gender;
  final String telegramUsername;
  final String birthDate;
  final String documentNumber;
  final String verificationType;
  final String rating;
  final bool isVerified;
  final String phoneNumber;
  final String documentFile1Path;
  final String documentFile2Path;
  final String photoPath;

  UserProfileEntity({
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.telegramUsername,
    required this.birthDate,
    required this.documentNumber,
    required this.verificationType,
    required this.rating,
    required this.isVerified,
    required this.phoneNumber,
    required this.documentFile1Path,
    required this.documentFile2Path,
    required this.photoPath,
  });
}
