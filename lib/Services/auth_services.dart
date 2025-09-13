// lib/services/auth_service.dart

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'api_urls.dart';

class AuthService {
  // Fungsi register yang diperbarui
  Future<dynamic> register({
    required String name,
    required String email,
    required String phone,
    required int institusiId,
    required String position,
    required String password,
    required String passwordConfirmation,
  }) async {
    final response = await http.post(
      Uri.parse(ApiUrls.registerUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'name': name,
        'email': email,
        'phone': phone,
        'institusi_id': institusiId,
        'position': position,
        'password': password,
        'password_confirmation': passwordConfirmation,
      }),
    );
    return jsonDecode(response.body);
  }

  // Fungsi login tidak perlu diubah, karena tidak ada informasi baru
  Future<dynamic> login(String email, String password) async {
    final response = await http.post(
      Uri.parse(ApiUrls.loginUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );
    return jsonDecode(response.body);
  }
}
