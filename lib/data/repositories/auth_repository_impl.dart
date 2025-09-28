// data/repositories/auth_repository_impl.dart
import 'package:schoolshare/core/services/auth/login_services.dart';
import 'package:schoolshare/data/models/users_model.dart';
import 'package:schoolshare/data/models/auth_response_model.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthService _authService;

  AuthRepositoryImpl({AuthService? authService})
      : _authService = authService ?? AuthService();

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final Map<String, dynamic> data = await _authService.login(
        email: email,
        password: password,
      );

      // Parse pakai AuthResponseModel
      final authResponse = AuthResponseModel.fromJson(data);

      // Inject token ke user
      return authResponse.user.copyWith(token: authResponse.token);
    } on Exception {
      rethrow;
    } catch (e) {
      throw Exception(
          'Terjadi kesalahan tak terduga saat login: ${e.toString()}');
    }
  }

  @override
  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String category,
    required int institutionId,
    required bool agreeToTerms,
    required String position,
  }) async {
    try {
      final Map<String, dynamic> data = await _authService.register(
        name: name,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
        category: category,
        institutionId: institutionId, // key tetap dihandle di AuthService
        agreeToTerms: agreeToTerms,
        position: position,
      );

      final authResponse = AuthResponseModel.fromJson(data);

      return authResponse.user.copyWith(token: authResponse.token);
    } on Exception {
      rethrow;
    } catch (e) {
      throw Exception(
          'Terjadi kesalahan tak terduga saat registrasi: ${e.toString()}');
    }
  }

  @override
  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    return null;
  }
}
