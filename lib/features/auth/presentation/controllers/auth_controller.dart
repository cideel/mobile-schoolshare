import 'package:get/get.dart';
import '../../domain/entities/auth_state.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../data/repositories/auth_repository_impl.dart';

class AuthController extends GetxController {
  final AuthRepository _authRepository = AuthRepositoryImpl();

  // Reactive variables
  final Rx<AuthState> _authState = const AuthState().obs;
  
  // Getters for easy access
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
      _authState.value = _authState.value.copyWith(
        status: AuthStatus.loading, 
        isLoading: true
      );
      
      if (email.isEmpty || password.isEmpty) {
        throw Exception('Email dan password harus diisi');
      }

      if (!_isValidEmail(email)) {
        throw Exception('Format email tidak valid');
      }

      final user = await _authRepository.login(email: email, password: password);
      
      _authState.value = _authState.value.copyWith(
        status: AuthStatus.authenticated,
        user: user,
        isLoading: false,
        errorMessage: null,
      );
    } catch (e) {
      print('Login error caught: $e'); // Debug print
      final errorMessage = e.toString().replaceAll('Exception: ', '');
      
      _authState.value = _authState.value.copyWith(
        status: AuthStatus.error,
        errorMessage: errorMessage.isNotEmpty ? errorMessage : 'Terjadi kesalahan saat login',
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
    required String institution,
    required bool agreeToTerms,
  }) async {
    try {
      _authState.value = _authState.value.copyWith(
        status: AuthStatus.loading, 
        isLoading: true
      );

      // Input validation
      if (name.isEmpty || email.isEmpty || password.isEmpty) {
        throw Exception('Semua field harus diisi');
      }

      if (!_isValidEmail(email)) {
        throw Exception('Format email tidak valid');
      }

      if (password.length < 6) {
        throw Exception('Password minimal 6 karakter');
      }

      if (password != confirmPassword) {
        throw Exception('Konfirmasi password tidak cocok');
      }

      if (category.isEmpty) {
        throw Exception('Kategori harus dipilih');
      }

      if (institution.isEmpty) {
        throw Exception('Institusi harus dipilih');
      }

      if (!agreeToTerms) {
        throw Exception('Anda harus menyetujui syarat dan ketentuan');
      }

      // Create user entity
      final user = User(
        id: DateTime.now().millisecondsSinceEpoch, // int instead of string
        roleGroupId: 1, // Default role group ID, adjust as needed
        email: email,
        profile: name, // Store name in profile field
        createdAt: DateTime.now(),
      );

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      _authState.value = _authState.value.copyWith(
        status: AuthStatus.authenticated,
        user: user,
        isLoading: false,
        errorMessage: null,
      );
    } catch (e) {
      print('Register error caught: $e'); // Debug print
      final errorMessage = e.toString().replaceAll('Exception: ', '');
      
      _authState.value = _authState.value.copyWith(
        status: AuthStatus.error,
        errorMessage: errorMessage.isNotEmpty ? errorMessage : 'Terjadi kesalahan saat registrasi',
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

  void logout() {
    _authState.value = const AuthState();
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }
}
