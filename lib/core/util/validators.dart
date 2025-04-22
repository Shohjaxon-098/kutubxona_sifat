String? validateRequired(String? value) {
  return (value == null || value.isEmpty) ? "Бу maydon majburiy" : null;
}

String? validatePassword(String? value) {
  return (value == null || value.length < 6) ? "Kami 6 belgi kiritishingiz kerak" : null;
}
