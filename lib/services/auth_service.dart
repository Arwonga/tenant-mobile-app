import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  static const String baseUrl = 'http://127.0.0.1:8000/api'; 
  final _storage = const FlutterSecureStorage();

  Future<bool> login(String email, String password, String role) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
        body: jsonEncode({'email': email, 'password': password, 'role': role}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        String token = data['token'];
        
        await _storage.write(key: 'auth_token', value: token);
        await _storage.write(key: 'user_role', value: role);
        return true;
      }
      return false;
    } catch (e) {
      print("API Connection Error: $e");
      return false;
    }
  }
}