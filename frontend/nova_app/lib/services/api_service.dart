import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/api_response.dart';
import '../utils/constants.dart';

class ApiService {
  ApiService._();
  static final ApiService instance = ApiService._();

  Future<ApiResponse> sendMessage(String userInput) async {
    try {
      final uri = Uri.parse(
        '${AppConstants.backendHost}${AppConstants.assistantEndpoint}',
      ).replace(queryParameters: {'user_input': userInput});

      final response = await http
          .post(uri, headers: {'Content-Type': 'application/json'})
          .timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        final body = response.body;
        final decoded = json.decode(body);
        final text = _extractText(decoded);
        return ApiResponse.success(text);
      } else {
        return ApiResponse.failure(
            'Server error ${response.statusCode}. Check if backend is running.');
      }
    } on Exception catch (e) {
      return ApiResponse.failure(
          'Cannot connect to Nova backend. Is it running on port 8000?\n$e');
    }
  }

  String _extractText(dynamic decoded) {
    if (decoded is String) return decoded;
    if (decoded is Map<String, dynamic>) {
      return decoded['response'] ??
          decoded['message'] ??
          decoded['text'] ??
          decoded['answer'] ??
          decoded['reply'] ??
          decoded.values.first?.toString() ??
          'No response.';
    }
    return decoded.toString();
  }
}
