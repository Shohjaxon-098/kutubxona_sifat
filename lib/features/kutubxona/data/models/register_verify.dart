class RegisterVerify {
  final String phone;
  final String libraryId;
  final String otpCode;
  RegisterVerify({
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
