import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/app_config.dart';
import '../models/philosophy_result.dart';

/// Custom exception so the UI can show user‑friendly error messages.
class ApiException implements Exception {
  final String message;
  ApiException(this.message);

  @override
  String toString() => message;
}

/// Single point of contact with the CORE backend.
class ApiService {
  final http.Client _client;

  ApiService({http.Client? client}) : _client = client ?? http.Client();

  Future<PhilosophyResult> diagnose(String userText) async {
    try {
      final response = await _client.post(
        Uri.parse(AppConfig.diagnoseEndpoint),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'answers': [userText]}),
      ).timeout(const Duration(seconds: 45));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        return PhilosophyResult.fromJson(data);
      } else if (response.statusCode == 429) {
        throw ApiException('Too many requests. Please slow down.');
      } else {
        throw ApiException('Server error ${response.statusCode}');
      }
    } catch (e) {
      if (e is ApiException) rethrow;           // let our own errors pass through
      // For any other error (network, timeout, JSON parsing, etc.)
      if (e.toString().contains('TimeoutException')) {
        throw ApiException('Connection timed out. Check your network.');
      }
      throw ApiException('Something went wrong. Please try again.');
    }
  }
}