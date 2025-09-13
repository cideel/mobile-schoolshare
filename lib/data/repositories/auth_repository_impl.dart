import 'package:schoolshare/data/models/users_model.dart';

import '../../features/auth/domain/entities/user.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../core/services/auth_mock_api_client.dart';
import '../datasources/api_exception.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<User> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await MockApiClient.post('/auth/login', body: {
        'email': email,
        'password': password,
      });

      final userData = response['data']['user'] as Map<String, dynamic>;
      return UserModel.fromJson(userData);
    } on ApiException catch (e) {
      // Re-throw ApiException with original message
      throw Exception(e.message);
    } catch (e) {
      // Handle other exceptions
      throw Exception('Terjadi kesalahan: ${e.toString()}');
    }
  }

  @override
  Future<User> register({
    required String email,
    required String password,
    required String name,
    required String role,
    required String university,
    String? department,
  }) async {
    try {
      final response = await MockApiClient.post('/auth/register', body: {
        'email': email,
        'password': password,
        'name': name,
        'role': role,
        'university': university,
        'department': department,
      });

      final userData = response['data']['user'] as Map<String, dynamic>;
      return UserModel.fromJson(userData);
    } on ApiException catch (e) {
      // Re-throw ApiException with original message
      throw Exception(e.message);
    } catch (e) {
      // Handle other exceptions
      throw Exception('Terjadi kesalahan: ${e.toString()}');
    }
  }

  @override
  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Future<User?> getCurrentUser() async {
    // Mock implementation
    return null;
  }
}