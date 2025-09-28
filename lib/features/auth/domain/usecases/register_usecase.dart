import 'package:schoolshare/data/models/users_model.dart';
import 'package:schoolshare/features/auth/domain/repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<UserModel> call({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String category,
    required int institution,
    required bool agreeToTerms,
    required String position,
  }) async {
    if (name.isEmpty) {
      throw Exception('Nama harus diisi');
    }

    if (email.isEmpty) {
      throw Exception('Email harus diisi');
    }

    if (!_isValidEmail(email)) {
      throw Exception('Format email tidak valid');
    }

    if (password.isEmpty) {
      throw Exception('Password harus diisi');
    }

    if (password.length < 6) {
      throw Exception('Password minimal 6 karakter');
    }

    // Konfirmasi password tidak boleh kosong (validasi sudah mencakup ini, tapi ditambah untuk eksplisit)
    if (confirmPassword.isEmpty) {
      throw Exception('Konfirmasi password harus diisi');
    }

    if (password != confirmPassword) {
      throw Exception('Konfirmasi password tidak cocok');
    }

    if (category.isEmpty) {
      throw Exception('Kategori harus dipilih');
    }

    if (!agreeToTerms) {
      throw Exception('Anda harus menyetujui syarat dan ketentuan');
    }
    // ----------------------------------------

    // Panggilan ke Repository dengan parameter yang baru
    return await repository.register(
      name: name,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
      category: category,
      institutionId: institution,
      agreeToTerms: agreeToTerms,
      position: position,
    );
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }
}
