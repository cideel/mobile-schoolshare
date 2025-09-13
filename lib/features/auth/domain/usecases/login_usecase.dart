import 'package:schoolshare/features/auth/domain/entities/user.dart';
import 'package:schoolshare/features/auth/domain/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<User> call({
    required String email,
    required String password,
  }) async {
    if (email.isEmpty) {
      throw Exception('Email tidak boleh kosong');
    }

    if (password.isEmpty) {
      throw Exception('Password tidak boleh kosong');
    }

    if (!_isValidEmail(email)) {
      throw Exception('Format email tidak valid');
    }

    return await repository.login(email: email, password: password);
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }
}
