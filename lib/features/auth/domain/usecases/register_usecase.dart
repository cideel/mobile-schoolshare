import 'package:schoolshare/features/auth/domain/entities/user.dart';
import 'package:schoolshare/features/auth/domain/repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<User> call({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String role,
    required String university,
    String? department,
  }) async {
    // Validasi input
    if (name.isEmpty) {
      throw Exception('Nama tidak boleh kosong');
    }

    if (email.isEmpty) {
      throw Exception('Email tidak boleh kosong');
    }

    if (password.isEmpty) {
      throw Exception('Password tidak boleh kosong');
    }

    if (confirmPassword.isEmpty) {
      throw Exception('Konfirmasi password tidak boleh kosong');
    }

    if (password != confirmPassword) {
      throw Exception('Password dan konfirmasi password tidak sama');
    }

    if (password.length < 6) {
      throw Exception('Password harus minimal 6 karakter');
    }

    if (!_isValidEmail(email)) {
      throw Exception('Format email tidak valid');
    }

    if (role.isEmpty) {
      throw Exception('Role harus dipilih');
    }

    if (university.isEmpty) {
      throw Exception('Universitas harus dipilih');
    }

    return await repository.register(
      name: name,
      email: email,
      password: password,
      role: role,
      university: university,
      department: department,
    );
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }
}
