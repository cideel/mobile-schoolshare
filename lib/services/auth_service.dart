import 'package:get/get.dart';
import 'package:schoolshare/models/models.dart';

// Auth Service - Business Logic untuk Authentication
class AuthService extends GetxService {
  // Storage untuk user yang sedang login
  final Rx<User?> _currentUser = Rx<User?>(null);
  final RxBool _isLoading = false.obs;
  final RxString _errorMessage = ''.obs;

  // Getters
  User? get currentUser => _currentUser.value;
  bool get isLoggedIn => _currentUser.value != null;
  bool get isLoading => _isLoading.value;
  String get errorMessage => _errorMessage.value;

  // Reactive getters
  Rx<User?> get currentUserRx => _currentUser;
  RxBool get isLoadingRx => _isLoading;

  // Login function - Business Logic
  Future<bool> login(String email, String password) async {
    try {
      _isLoading.value = true;
      _errorMessage.value = '';

      // Validasi input
      if (email.isEmpty || password.isEmpty) {
        throw Exception('Email dan password harus diisi');
      }

      if (!_isValidEmail(email)) {
        throw Exception('Format email tidak valid');
      }

      // Simulasi network delay
      await Future.delayed(Duration(milliseconds: 800));

      // Hardcode login logic
      User? user = _authenticateUser(email, password);
      
      if (user != null) {
        _currentUser.value = user;
        _isLoading.value = false;
        
        // Show success message
        Get.snackbar(
          'Login Berhasil',
          'Selamat datang, ${user.name}!',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Get.theme.primaryColor,
          colorText: Get.theme.colorScheme.onPrimary,
        );
        
        return true;
      } else {
        throw Exception('Email atau password salah');
      }
    } catch (e) {
      _errorMessage.value = e.toString();
      _isLoading.value = false;
      
      // Show error message
      Get.snackbar(
        'Login Gagal',
        _errorMessage.value,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
      );
      
      return false;
    }
  }

  // Register function - Business Logic
  Future<bool> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String category,
    required String institution,
    required bool agreeToTerms,
  }) async {
    try {
      _isLoading.value = true;
      _errorMessage.value = '';

      // Validasi input
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

      // Simulasi network delay
      await Future.delayed(Duration(milliseconds: 1000));

      // Create new user
      User newUser = User(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        email: email,
        name: name,
        institution: institution,
        category: category,
        joinedDate: DateTime.now(),
      );

      _currentUser.value = newUser;
      _isLoading.value = false;

      // Show success message
      Get.snackbar(
        'Registrasi Berhasil',
        'Selamat datang, ${newUser.name}!',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Get.theme.primaryColor,
        colorText: Get.theme.colorScheme.onPrimary,
      );

      return true;
    } catch (e) {
      _errorMessage.value = e.toString();
      _isLoading.value = false;
      
      // Show error message
      Get.snackbar(
        'Registrasi Gagal',
        _errorMessage.value,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
      );
      
      return false;
    }
  }

  // Logout function
  Future<void> logout() async {
    _currentUser.value = null;
    _errorMessage.value = '';
    
    Get.snackbar(
      'Logout',
      'Anda telah keluar dari aplikasi',
      snackPosition: SnackPosition.TOP,
    );
  }

  // Helper function - Authenticate user
  User? _authenticateUser(String email, String password) {
    // Hardcode users - Business Logic
    if (email == 'admin@schoolshare.com' && password == 'admin123') {
      return User(
        id: '1',
        email: 'admin@schoolshare.com',
        name: 'Admin SchoolShare',
        institution: 'SchoolShare Platform',
        category: 'Perguruan Tinggi',
        position: 'Administrator',
        joinedDate: DateTime.now().subtract(Duration(days: 365)),
        isVerified: true,
      );
    } else if (email == 'user@test.com' && password == 'user123') {
      return User(
        id: '2',
        email: 'user@test.com',
        name: 'Test User',
        institution: 'SMA Negeri 1 Jakarta',
        category: 'SMA/SMK/MA',
        position: 'Guru',
        department: 'Bahasa Indonesia',
        joinedDate: DateTime.now().subtract(Duration(days: 30)),
        isVerified: false,
      );
    }
    
    return null; // User not found
  }

  // Helper function - Validate email
  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  // Clear error message
  void clearError() {
    _errorMessage.value = '';
  }
}
