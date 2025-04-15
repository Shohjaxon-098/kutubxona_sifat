class ApiResult {
  final bool success;
  final dynamic data;
  final String? message;

  ApiResult({
    required this.success,
    this.data,
    this.message,
  });
}
