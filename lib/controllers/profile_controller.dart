import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schoolshare/models/models.dart';

// Profile Controller - UI Logic untuk Profile Management
class ProfileController extends GetxController {
  // Form controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final positionController = TextEditingController();
  final departmentController = TextEditingController();
  final locationController = TextEditingController();

  // UI state
  final RxString selectedCategory = 'SMA/SMK/MA'.obs;
  final RxString selectedInstitution = ''.obs;
  final RxString avatarUrl = ''.obs;
  final RxBool isEditing = false.obs;
  final RxBool isLoading = false.obs;

  // Mock data for institutions
  final Map<String, List<String>> institutionsByCategory = {
    'SD/MI': [
      'SD Negeri 1 Jakarta',
      'SD Negeri 2 Jakarta',
      'MI Al-Azhar',
    ],
    'SMP': [
      'SMP Negeri 1 Jakarta',
      'SMP Negeri 2 Jakarta',
      'SMP Swasta Al-Falah',
    ],
    'SMA/SMK/MA': [
      'SMA Negeri 1 Jakarta',
      'SMA Negeri 2 Jakarta',
      'SMK Negeri 1 Jakarta',
      'MA Al-Ikhlas',
    ],
    'Perguruan Tinggi': [
      'Universitas Indonesia',
      'Universitas Gadjah Mada',
      'Institut Teknologi Bandung',
      'Universitas Airlangga',
    ],
  };

  // Categories
  final List<String> categories = ['SD/MI', 'SMP', 'SMA/SMK/MA', 'Perguruan Tinggi'];

  // Mock current user for development - TODO: Get from actual auth service
  final Rx<User?> _currentUser = Rx<User?>(null);

  // Getters
  User? get currentUser => _currentUser.value;
  List<String> get availableInstitutions => institutionsByCategory[selectedCategory.value] ?? [];

  @override
  void onInit() {
    super.onInit();
    _initializeMockUser();
    _initializeUserData();
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    positionController.dispose();
    departmentController.dispose();
    locationController.dispose();
    super.onClose();
  }

  // Initialize mock user data for development
  void _initializeMockUser() {
    _currentUser.value = User(
      id: '1',
      name: 'Johan Liebert',
      email: 'johan.liebert@email.com',
      institution: 'SMA Negeri 1 Jakarta',
      category: 'SMA/SMK/MA',
      position: 'Guru Bahasa Indonesia',
      department: 'Bahasa',
      location: 'Jakarta',
      joinedDate: DateTime.now().subtract(const Duration(days: 365)),
      isVerified: true,
    );
  }

  // Initialize user data into form controllers
  void _initializeUserData() {
    final user = currentUser;
    if (user != null) {
      nameController.text = user.name;
      emailController.text = user.email;
      positionController.text = user.position ?? '';
      departmentController.text = user.department ?? '';
      locationController.text = user.location ?? '';
      selectedCategory.value = user.category;
      selectedInstitution.value = user.institution;
      avatarUrl.value = user.avatar ?? '';
    }
  }

  // Toggle edit mode
  void toggleEditMode() {
    if (isEditing.value) {
      // Cancel editing - restore original data
      _initializeUserData();
    }
    isEditing.value = !isEditing.value;
  }

  // Save profile changes
  Future<void> saveProfile() async {
    if (!_validateForm()) {
      Get.snackbar('Error', 'Mohon lengkapi semua field yang diperlukan');
      return;
    }

    isLoading.value = true;

    // Mock implementation - TODO: Replace with actual service call
    await Future.delayed(const Duration(milliseconds: 1000));

    final updatedUser = currentUser?.copyWith(
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      position: positionController.text.trim(),
      department: departmentController.text.trim(),
      location: locationController.text.trim(),
      category: selectedCategory.value,
      institution: selectedInstitution.value,
      avatar: avatarUrl.value,
    );

    // Update user in mock data
    if (updatedUser != null) {
      _currentUser.value = updatedUser;
    }

    isLoading.value = false;
    isEditing.value = false;
    Get.snackbar('Sukses', 'Profil berhasil diperbarui');
  }

  // Change category and reset institution
  void changeCategory(String category) {
    selectedCategory.value = category;
    selectedInstitution.value = '';
  }

  // Set institution
  void setInstitution(String institution) {
    selectedInstitution.value = institution;
  }

  // Update profile image
  void updateAvatar(String imageUrl) {
    avatarUrl.value = imageUrl;
  }

  // Validation
  bool _validateForm() {
    return nameController.text.trim().isNotEmpty &&
           emailController.text.trim().isNotEmpty &&
           selectedCategory.value.isNotEmpty &&
           selectedInstitution.value.isNotEmpty;
  }

  // Statistics - Mock data
  Map<String, dynamic> get userStatistics {
    return {
      'totalContents': 15,
      'totalViews': 1250,
      'totalDownloads': 89,
      'totalRecommendations': 67,
      'joinedDays': currentUser != null 
          ? DateTime.now().difference(currentUser!.joinedDate).inDays 
          : 0,
    };
  }

  // Recent activities - Mock data
  List<Map<String, dynamic>> get recentActivities {
    return [
      {
        'type': 'content_uploaded',
        'title': 'Mengunggah konten "Panduan Kurikulum Merdeka"',
        'time': DateTime.now().subtract(const Duration(hours: 2)),
      },
      {
        'type': 'content_shared',
        'title': 'Membagikan "Modul Pembelajaran Digital"',
        'time': DateTime.now().subtract(const Duration(days: 1)),
      },
      {
        'type': 'forum_posted',
        'title': 'Memposting di forum "Tips Mengajar"',
        'time': DateTime.now().subtract(const Duration(days: 3)),
      },
    ];
  }

  // Account actions
  Future<void> changePassword() async {
    // Navigate to change password page
    Get.toNamed('/change-password');
  }

  Future<void> deleteAccount() async {
    final confirmed = await Get.dialog<bool>(
      AlertDialog(
        title: const Text('Hapus Akun'),
        content: const Text(
          'Apakah Anda yakin ingin menghapus akun? '
          'Tindakan ini tidak dapat dibatalkan dan semua data akan hilang.',
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      // TODO: Implement account deletion
      Get.snackbar('Info', 'Fitur hapus akun akan segera tersedia');
    }
  }

  Future<void> logout() async {
    // TODO: Implement proper logout through auth service
    _currentUser.value = null;
    Get.offAllNamed('/login');
  }

  // Navigation
  void goToSettings() {
    Get.toNamed('/settings');
  }

  void goToHelp() {
    Get.toNamed('/help');
  }

  void goToAbout() {
    Get.toNamed('/about');
  }
}
