class RegisterStep1 {
  final String phone;
  final String libraryId;

  RegisterStep1({required this.phone,required this.libraryId});

  Map<String, dynamic> toJson() => {
    'phone_number': phone,
    'library_id': libraryId,
  };
}
