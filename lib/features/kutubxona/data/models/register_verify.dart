class RegisterVerifyModel {
  final String phone;
  final String libraryId;
  final String otpCode;
  RegisterVerifyModel({
    required this.phone,
    required this.libraryId,
    required this.otpCode,
  });

  Map<String, dynamic> toJson() => {
    'phone_number': phone,
    'library_id': libraryId,

    'otp_code': otpCode,
  };
}
