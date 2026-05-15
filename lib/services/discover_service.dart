import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class DiscoverService {
  final String baseUrl = Platform.isAndroid 
      ? 'http://10.0.2.2:5000/api/discover' 
      : 'http://localhost:5000/api/discover';

  Future<Map<String, dynamic>> getDiscoverData() async {
    try {
      final response = await http.get(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
      throw Exception('Failed to load data');
    } catch (e) {
      // Return mock data if server is down for seamless UI experience
      return {
        'streams': [
          {'title': 'AI & Robotics', 'icon': 'smart_toy', 'color': 'blue', 'subtitle': 'Real-time: Industry growth +15%'},
          {'title': 'Fintech', 'icon': 'account_balance', 'color': 'green', 'subtitle': 'Expanding in digital payments.'},
          {'title': 'Cybersecurity', 'icon': 'security', 'color': 'red', 'subtitle': 'High demand for data protection.'},
        ],
        'skills': [
          {'title': 'Prompt Engineering', 'tag': 'Trending', 'icon': 'bolt'},
          {'title': 'Emotional Intelligence', 'tag': 'Soft Skill', 'icon': 'psychology'},
          {'title': 'Blockchain Dev', 'tag': 'High Pay', 'icon': 'link'},
        ],
        'scholarships': [
          {'name': 'Tech Giants 2024', 'amount': '\$15,000', 'deadline': 'Ends in 5 days'},
          {'name': 'Future Leaders', 'amount': 'Full Ride', 'deadline': 'Ends in 2 weeks'},
        ]
      };
    }
  }
}
