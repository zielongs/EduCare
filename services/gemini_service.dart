/*--------------------------------------------------
Author      : Alyssa Annabelle binti James Pekan
Updated by  :
Tested by   :
Date        : 04 January 2026
Description :
  - Service for interacting with the Gemini API.
  - Handles HTTP requests and response parsing.
--------------------------------------------------*/
import 'dart:convert';
import 'package:http/http.dart' as http;

class GeminiService {
  static const _apiKey = 'AIzaSyB6X8WALeQJ7HqM_wu1WNhmaNlIVoO1lsc';
  static const _endpoint =
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent';

  Future<String> generateText(String prompt) async {
    final uri = Uri.parse('$_endpoint?key=$_apiKey');

    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'contents': [
          {
            'parts': [
              {'text': prompt}
            ]
          }
        ]
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Gemini error ${response.statusCode}: ${response.body}');
    }

    final decoded = jsonDecode(response.body);
    return decoded['candidates'][0]['content']['parts'][0]['text'];
  }
}
