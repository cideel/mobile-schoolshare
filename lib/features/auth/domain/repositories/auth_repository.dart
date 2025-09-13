// lib/features/auth/domain/repositories/auth_repository.dart
import '../entities/user.dart';

abstract class AuthRepository {
  Future<User> login({
    required String email,
    required String password,
  });

  Future<User> register({
    required String email,
    required String password,
    required String name,
    required String role,
    required String university,
    String? department,
  });

  Future<void> logout();
  Future<User?> getCurrentUser();
}