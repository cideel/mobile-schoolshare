// lib/features/auth/controllers/auth_controller.dart
import 'dart:developer';

import 'package:get/get.dart';
import '../domain/entities/auth_state.dart';
import '../domain/entities/user.dart';
import '../domain/repositories/auth_repository.dart';
import 'package:schoolshare/data/repositories/auth_repository_impl.dart';
import 'package:schoolshare/core/utils/storage_utils.dart'; // ⬅️ tambahkan ini

class AuthController extends GetxController {
  final AuthRepository _authRepository = AuthRepositoryImpl();

  final Rx<AuthState> _authState = const AuthState().obs;

  Rx<AuthState> get authStateRx => _authState;
  AuthState get authState => _authState.value;
  bool get isLoading => _authState.value.isLoading;
  bool get isAuthenticated => _authState.value.isAuthenticated;
  bool get hasError => _authState.value.hasError;
  String? get errorMessage => _authState.value.errorMessage;
  User? get user => _authState.value.user;

  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      _authState.value = _authState.value
          .copyWith(status: AuthStatus.loading, isLoading: true);

      if (email.isEmpty || password.isEmpty) {
        throw Exception('Email dan password harus diisi');
      }

      if (!_isValidEmail(email)) {
        throw Exception('Format email tidak valid');
      }

      final user = await _authRepository.login(
        email: email,
        password: password,
      );

      if (user.token != null) {
        await StorageUtils.saveToken(user.token!);
        log('Saved token: ${user.token}');
      }

      _authState.value = _authState.value.copyWith(
        status: AuthStatus.authenticated,
        user: user,
        isLoading: false,
        errorMessage: null,
      );
    } catch (e) {
      print('Login error caught: $e');
      final errorMessage = e.toString().replaceAll('Exception: ', '');

      _authState.value = _authState.value.copyWith(
        status: AuthStatus.error,
        errorMessage: errorMessage.isNotEmpty
            ? errorMessage
            : 'Terjadi kesalahan saat login',
        isLoading: false,
      );
    }
  }

  Future<void> register({
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
      _authState.value = _authState.value
          .copyWith(status: AuthStatus.loading, isLoading: true);

      final user = await _authRepository.register(
        name: name,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
        category: category,
        institutionId: institutionId,
        agreeToTerms: agreeToTerms,
        position: position,
      );

      // Simpan token juga kalau register berhasil
      if (user.token != null) {
        await StorageUtils.saveToken(user.token!);
      }

      _authState.value = _authState.value.copyWith(
        status: AuthStatus.authenticated,
        user: user,
        isLoading: false,
        errorMessage: null,
      );
    } catch (e) {
      print('Register error caught: $e');
      final errorMessage = e.toString().replaceAll('Exception: ', '');

      _authState.value = _authState.value.copyWith(
        status: AuthStatus.error,
        errorMessage: errorMessage.isNotEmpty
            ? errorMessage
            : 'Terjadi kesalahan saat registrasi',
        isLoading: false,
      );
    }
  }

  void clearError() {
    if (_authState.value.hasError) {
      _authState.value = _authState.value.copyWith(
        status: AuthStatus.initial,
        errorMessage: null,
      );
    }
  }

  Future<void> logout() async {
    await StorageUtils.clearToken(); // ⬅️ hapus token
    _authState.value = const AuthState();
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }
}
