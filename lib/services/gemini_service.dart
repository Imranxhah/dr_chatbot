import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/app_constants.dart';

class GeminiService {
  static Future<String> generateContent(String prompt) async {
    if (AppConstants.geminiApiKey.isEmpty ||
        AppConstants.geminiApiKey == 'YOUR_ACTUAL_GEMINI_API_KEY') {
      throw Exception(AppConstants.errorApiMissing);
    }

    final url = Uri.parse(
      '${AppConstants.geminiApiBaseUrl}/${AppConstants.geminiModel}:generateContent?key=${AppConstants.geminiApiKey}',
    );

    try {
      final response = await http
          .post(
            url,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'contents': [
                {
                  'parts': [
                    {'text': prompt},
                  ],
                },
              ],
              'generationConfig': {
                'temperature': AppConstants.apiTemperature,
                'maxOutputTokens': AppConstants.apiMaxTokens,
              },
            }),
          )
          .timeout(const Duration(seconds: AppConstants.apiTimeout));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['candidates'] != null && data['candidates'].isNotEmpty) {
          return data['candidates'][0]['content']['parts'][0]['text'];
        } else {
          throw Exception('No response from API');
        }
      } else {
        throw Exception('API Error: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      rethrow;
    }
  }

  static String getErrorMessage(dynamic error) {
    String errorMessage = 'Error: ${error.toString()}';

    if (error.toString().contains('SocketException') ||
        error.toString().contains('Failed host lookup')) {
      errorMessage = AppConstants.errorNoInternet;
    } else if (error.toString().contains('API_KEY_INVALID') ||
        error.toString().contains('403')) {
      errorMessage = AppConstants.errorInvalidApiKey;
    } else if (error.toString().contains('TimeoutException')) {
      errorMessage = AppConstants.errorTimeout;
    }

    return errorMessage;
  }
}
