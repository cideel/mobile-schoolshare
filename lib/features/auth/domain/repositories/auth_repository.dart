

import 'package:schoolshare/data/models/users_model.dart';

abstract class AuthRepository {
  Future<UserModel> login({
    required String email,
    required String password,
  });

  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String category,
    required int institutionId, // <-- Nama parameter diperbarui di sini
    required bool agreeToTerms,
    required String position,
  });

  Future<void> logout();
  Future<UserModel?> getCurrentUser();
}
