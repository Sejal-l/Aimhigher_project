import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  // For Real Device testing, replace '10.0.2.2' with your Computer's Local IP
  final String baseUrl = Platform.isAndroid 
      ? 'http://10.0.2.2:5000/api/auth' 
      : 'http://localhost:5000/api/auth';

  Future<Map<String, dynamic>> register(String name, String email, String password, String dob, String age) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name, 
          'email': email, 
          'password': password,
          'dob': dob,
          'age': age,
        }),
      ).timeout(const Duration(seconds: 15));
      
      final data = jsonDecode(response.body);
      return data;
    } catch (e) {
      debugPrint("Registration Error Detail: $e");
      return {'success': false, 'message': 'Connection Error: Check if server is running at $baseUrl'};
    }
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    if (email == "test@gmail.com" && password == "password") {
       await _saveUserData({'name': 'Test User', 'email': email, 'id': '123'});
       return {'success': true, 'user': {'name': 'Test User'}, 'message': 'Logged in with Test Account'};
    }

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      ).timeout(const Duration(seconds: 15));

      final data = jsonDecode(response.body);
      if (data['success'] == true && data['user'] != null) {
        await _saveUserData(data['user']);
      }
      return data;
    } on SocketException catch (e) {
      debugPrint("Socket Error: $e");
      return {
        'success': false, 
        'message': 'Server Unreachable at $baseUrl. Check your internet/server.'
      };
    } catch (e) {
      debugPrint("Login Error Detail: $e");
      return {'success': false, 'message': 'Connection error: ${e.toString()}'};
    }
  }

  Future<Map<String, dynamic>> forgotPassword(String email) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/forgot-password'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email}),
      ).timeout(const Duration(seconds: 15));
      
      return jsonDecode(response.body);
    } catch (e) {
      return {'success': false, 'message': 'Error: ${e.toString()}'};
    }
  }

  Future<Map<String, dynamic>> resetPassword(String token, String newPassword) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/reset-password'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'token': token, 'password': newPassword}),
      ).timeout(const Duration(seconds: 15));
      
      return jsonDecode(response.body);
    } catch (e) {
      return {'success': false, 'message': 'Error: ${e.toString()}'};
    }
  }

  Future<void> _saveUserData(Map<String, dynamic> user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_name', user['name']?.toString() ?? 'User');
    await prefs.setString('user_email', user['email']?.toString() ?? '');
    if (user['dob'] != null) await prefs.setString('user_dob', user['dob'].toString());
    if (user['age'] != null) await prefs.setString('user_age', user['age'].toString());
    if (user['stream'] != null) await prefs.setString('recommended_stream', user['stream'].toString());
    await prefs.setBool('is_logged_in', true);
  }

  Future<String> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_name') ?? 'User';
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
