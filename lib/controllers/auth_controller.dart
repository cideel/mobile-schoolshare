import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schoolshare/services/auth_service.dart';
import 'package:schoolshare/models/models.dart';
import 'auth_state.dart';

// Auth Controller - UI Logic untuk Authentication
class AuthController extends GetxController {
  // Get service
  final AuthService _authService = Get.find<AuthService>();

  // Form controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // UI state
  final RxBool obscurePassword = true.obs;
  final RxBool obscureConfirmPassword = true.obs;
  final Rx<String?> selectedCategory = Rx<String?>(null);
  final RxString selectedInstitution = ''.obs;
  final RxBool agreeToTerms = false.obs;

  // Categories
  final List<String> categories = ['SD/MI', 'SMP', 'SMA/SMK/MA', 'Perguruan Tinggi'];

  // Getters dari service
  bool get isLoading => _authService.isLoading;
  bool get isLoggedIn => _authService.isLoggedIn;
  User? get currentUser => _authService.currentUser;
  String get errorMessage => _authService.errorMessage;

  // Reactive getters dari service
  RxBool get isLoadingRx => _authService.isLoadingRx;
  Rx<User?> get currentUserRx => _authService.currentUserRx;

  @override
  void onInit() {
    super.onInit();
    // Listen to auth state changes
    ever(_authService.currentUserRx, (User? user) {
      if (user != null) {
        // Navigate to home when logged in
        Get.offAllNamed('/home');
      }
    });
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  // Login handler
  Future<void> handleLogin() async {
    await _authService.login(
      emailController.text.trim(),
      passwordController.text,
    );
  }

  // Register handler
  Future<void> handleRegister() async {
    await _authService.register(
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      password: passwordController.text,
      confirmPassword: confirmPasswordController.text,
      category: selectedCategory.value ?? '',
      institution: selectedInstitution.value,
      agreeToTerms: agreeToTerms.value,
    );
  }

  // Logout handler
  Future<void> handleLogout() async {
    await _authService.logout();
    Get.offAllNamed('/login');
  }

  // Toggle password visibility
  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  void toggleConfirmPasswordVisibility() {
    obscureConfirmPassword.value = !obscureConfirmPassword.value;
  }

  // Set category
  void setCategory(String? category) {
    selectedCategory.value = category;
  }

  // Set institution
  void setInstitution(String institution) {
    selectedInstitution.value = institution;
  }

  // Toggle agree to terms
  void toggleAgreeToTerms(bool? value) {
    agreeToTerms.value = value ?? false;
  }

  // Clear error
  void clearError() {
    _authService.clearError();
  }

  // Compatibility methods for existing UI
  Future<void> login(String email, String password) async {
    emailController.text = email;
    passwordController.text = password;
    await handleLogin();
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
    nameController.text = name;
    emailController.text = email;
    passwordController.text = password;
    confirmPasswordController.text = confirmPassword;
    selectedCategory.value = category;
    selectedInstitution.value = institution;
    this.agreeToTerms.value = agreeToTerms;
    await handleRegister();
  }

  // Mock authState for compatibility
  AuthState get authState => AuthState(
    isLoading: isLoading,
    isAuthenticated: isLoggedIn,
    user: currentUser,
    hasError: errorMessage.isNotEmpty,
    errorMessage: errorMessage,
  );
}
