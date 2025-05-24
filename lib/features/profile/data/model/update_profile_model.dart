class UpdateProfileModel {
  final String firstName;
  final String lastName;
  final String gender;
  final String telegram;
  final String password;
  final String birthDate;
  final String documentType;
  final String passportInfo;
  final String? imagePath;
  final String? documentPath;

  UpdateProfileModel({
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.telegram,
    required this.password,
    required this.birthDate,
    required this.documentType,
    required this.passportInfo,
    this.imagePath,
    this.documentPath,
  });

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'gender': gender,
      'telegram': telegram,
      'password': password,
      'birth_date': birthDate,
      'document_type': documentType,
      'passport_info': passportInfo,
    };
  }
}
