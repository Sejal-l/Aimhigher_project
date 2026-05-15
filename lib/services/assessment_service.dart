import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class AssessmentService {
  final String baseUrl = Platform.isAndroid 
      ? 'http://10.0.2.2:5000/api/assessment' 
      : 'http://localhost:5000/api/assessment';

  Future<Map<String, dynamic>> submitAssessment(String userId, List<Map<String, dynamic>> answers) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/submit'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'userId': userId,
          'answers': answers,
        }),
      );
      return jsonDecode(response.body);
    } catch (e) {
      return {
        'success': false, 
        'message': 'Connection Error',
        'careerSuggestion': 'Career Consultant',
        'reasoning': 'Local fallback: Based on your diverse interests.'
      };
    }
  }
}
