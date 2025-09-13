// lib/features/auth/data/datasources/mock_api_client.dart
import 'dart:math';
import '../../data/datasources/api_exception.dart';
import '../../data/datasources/mock_data.dart';

class MockApiClient {
  static Future<void> _simulateNetworkDelay() async {
    await Future.delayed(
      MockAuthData.networkDelay + Duration(milliseconds: Random().nextInt(500))
    );
  }

  static Future<Map<String, dynamic>> post(
    String endpoint, {
    Map<String, dynamic>? body,
  }) async {
    await _simulateNetworkDelay();

   
    return _handleEndpoint(endpoint, body);
  }

  static Map<String, dynamic> _handleEndpoint(
    String endpoint, 
    Map<String, dynamic>? body,
  ) {
    switch (endpoint) {
      case '/auth/login':
        return _handleLogin(body!);
      case '/auth/register':
        return _handleRegister(body!);
      default:
        throw ApiException('Endpoint not found: $endpoint', 404);
    }
  }

  static Map<String, dynamic> _handleLogin(Map<String, dynamic> body) {
    _validateLoginInput(body);

    final email = body['email'] as String;
    final password = body['password'] as String;

    final mockUsers = MockAuthData.predefinedUsers;

    if (!mockUsers.containsKey(email)) {
      throw ApiException('Email tidak terdaftar. Silakan gunakan akun demo atau daftar terlebih dahulu.', 404);
    }

    final userData = mockUsers[email]!;
    if (userData['password'] != password) {
      throw ApiException('Password salah. Silakan coba lagi.', 401);
    }

    // Update last login time
    final userCopy = Map<String, dynamic>.from(userData['user']);
    userCopy['lastLoginAt'] = DateTime.now().toIso8601String();

    return {
      'success': true,
      'message': 'Login berhasil',
      'data': {
        'user': userCopy,
        'token': 'mock_jwt_token_${DateTime.now().millisecondsSinceEpoch}',
      }
    };
  }

  static void _validateLoginInput(Map<String, dynamic> body) {
    if (body['email'] == null || (body['email'] as String).isEmpty) {
      throw ApiException('Email tidak boleh kosong', 400);
    }
    
    if (body['password'] == null || (body['password'] as String).isEmpty) {
      throw ApiException('Password tidak boleh kosong', 400);
    }

    final email = body['email'] as String;
    if (!_isValidEmail(email)) {
      throw ApiException('Format email tidak valid', 400);
    }
  }

  static bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  static Map<String, dynamic> _handleRegister(Map<String, dynamic> body) {
    _validateRegisterInput(body);

    return {
      'success': true,
      'message': 'Registrasi berhasil',
      'data': {
        'user': {
          'id': 'user_${DateTime.now().millisecondsSinceEpoch}',
          'email': body['email'],
          'name': body['name'],
          'role': body['role'],
          'profileImage': null,
          'createdAt': DateTime.now().toIso8601String(),
          'lastLoginAt': null,
          'isEmailVerified': false,
          'phoneNumber': null,
          'university': body['university'],
          'department': body['department'],
        },
        'token': 'mock_jwt_token_${DateTime.now().millisecondsSinceEpoch}',
      }
    };
  }

  static void _validateRegisterInput(Map<String, dynamic> body) {
    final validations = {
      'email': 'Email tidak boleh kosong',
      'password': 'Password tidak boleh kosong',
      'name': 'Nama tidak boleh kosong',
      'role': 'Role harus dipilih',
      'university': 'Universitas harus dipilih',
    };

    for (final entry in validations.entries) {
      final field = entry.key;
      final message = entry.value;
      
      if (body[field] == null || (body[field] as String).isEmpty) {
        throw ApiException(message, 400);
      }
    }
  }
}