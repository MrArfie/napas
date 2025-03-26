import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _apiUrl = 'http://localhost:5000/api/auth';  // Backend API URL

  // Register a new user
  Future<Map<String, dynamic>> register(String name, String email, String password) async {
    final response = await http.post(
      Uri.parse('$_apiUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'name': name,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 201) {
      // Registration successful, return the token and user details
      final data = json.decode(response.body);
      await _saveSession(data['token'], data['user'], data['role']);
      return {'success': true, 'message': 'Registration successful'};
    } else {
      // Registration failed, return the error message
      final error = json.decode(response.body)['message'] ?? 'Registration failed';
      return {'success': false, 'message': error};
    }
  }

  // Login an existing user
  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$_apiUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      // Login successful, return the token and user details
      final data = json.decode(response.body);
      if (data.containsKey('token') && data.containsKey('user') && data.containsKey('role')) {
        // Ensure 'token', 'user', and 'role' are available in the response
        await _saveSession(data['token'], data['user'], data['role']);
        return {'success': true, 'message': 'Login successful'};
      } else {
        return {'success': false, 'message': 'Missing data in response'};
      }
    } else {
      // Login failed, return the error message
      final error = json.decode(response.body)['message'] ?? 'Login failed';
      return {'success': false, 'message': error};
    }
  }

  // Save session data (token, user details, and role)
  Future<void> _saveSession(String token, Map<String, dynamic> user, String role) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth-token', token);
    await prefs.setString('user', json.encode(user));
    await prefs.setString('role', role);  // Save role in shared preferences
  }

  // Retrieve the stored token
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth-token');
  }

  // Retrieve the stored user data
  Future<Map<String, dynamic>?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('user');
    if (userJson != null) {
      return json.decode(userJson);
    }
    return null;
  }

  // Retrieve the stored role
  Future<String?> getRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('role');  // Retrieve the saved role
  }

  // Logout user by clearing the session data
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth-token');
    await prefs.remove('user');
    await prefs.remove('role');  // Remove role as well
  }

  // Check if the user is authenticated (if token exists)
  Future<bool> isAuthenticated() async {
    final token = await getToken();
    return token != null;
  }

  // Check if the user is an admin
  Future<bool> isAdmin() async {
    final role = await getRole();
    return role == 'admin';  // Check if the role is 'admin'
  }
}
