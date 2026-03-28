class ApiResponse {
  final String text;
  final bool success;
  final String? error;

  const ApiResponse({
    required this.text,
    required this.success,
    this.error,
  });

  factory ApiResponse.success(String text) =>
      ApiResponse(text: text, success: true);

  factory ApiResponse.failure(String error) =>
      ApiResponse(text: '', success: false, error: error);
}
