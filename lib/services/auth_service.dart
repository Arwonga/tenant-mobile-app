import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  // Using 10.0.2.2 if testing via Android, or localhost for Web.
  // Replace with your actual local network IP or domain!
  static const String baseUrl = 'http://127.0.0.1:8000/api'; 
  final _storage = const FlutterSecureStorage();

  Future<bool> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        String token = data['token'];
        
        // Lock the token into the secure encrypted vault
        await _storage.write(key: 'auth_token', value: token);
        return true;
      }
      return false;
    } catch (e) {
      print("API Connection Error: $e");
      return false;
    }
  }
}