import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:schoolshare/core/services/profile/header_profile_services.dart';
import 'package:schoolshare/features/own_profile/controllers/header_profile_controller.dart';

class UpdateProfileController extends GetxController {
  // Loading states - menggunakan simple variables dan update() untuk notifikasi
  bool isLoading = false;
  bool isSaving = false;

  // Form controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  // Profile photo
  File? profilePhotoFile;
  String currentProfilePhotoUrl = '';

  // Form validation
  final formKey = GlobalKey<FormState>();

  // Dependencies
  final ImagePicker _imagePicker = ImagePicker();
  final HeaderProfileService _profileService = HeaderProfileService();

  @override
  void onInit() {
    super.onInit();
    // Simple initialization
    isLoading = false;
    isSaving = false;
    profilePhotoFile = null;
    currentProfilePhotoUrl = '';
  }

  /// Public method untuk load profile data yang bisa dipanggil dari widget
  void loadProfileData() {
    if (isLoading) return; // Hindari multiple calls
    _loadCurrentProfileData();
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.onClose();
  }

  /// Load current profile data into form
  void _loadCurrentProfileData() async {
    // Double check controller is still active
    if (isClosed) return;
    
    isLoading = true;
    update(); // Notify GetBuilder

    try {
      // Load data from API menggunakan HeaderProfileService
      final profileData = await _profileService.getUserProfile();
      
      // Debug: Print response data
      print('Profile API Response: $profileData');
      
      // Extract data dari response API
      final userData = profileData['data'] ?? profileData;
      print('User Data: $userData');
      
      // Update form dengan data dari API - konversi semua ke string dengan aman
      nameController.text = _safeString(userData['name']);
      emailController.text = _safeString(userData['email']);
      phoneController.text = _safeString(userData['phone']);
      
      // Update profile photo URL jika ada  
      final profilePicture = userData['profile'] ?? userData['profile_picture'];
      print('Profile Picture: $profilePicture');
      if (profilePicture != null) {
        final profileUrl = _safeString(profilePicture);
        if (profileUrl.isNotEmpty) {
          currentProfilePhotoUrl = profileUrl;
          print('Profile URL Set: $currentProfilePhotoUrl');
        }
      } else {
        print('No profile photo URL, showing default avatar. URL: "$profilePicture"');
      }

    } catch (e) {
      if (!isClosed) {
        // Fallback ke data demo jika API gagal
        nameController.text = "Danudiraja User";
        emailController.text = "danu1@gmail.com";
        phoneController.text = "89523060189";
        currentProfilePhotoUrl = "profile_pictures/0BJWDjAq9JQpC1pyq5bfkyWuIMGAlbTUFGt6Tfnm.jpg";
        
        _showError('Gagal memuat data profil: $e');
      }
    } finally {
      if (!isClosed) {
        isLoading = false;
        update(); // Notify GetBuilder
      }
    }
  }

  /// Pick image from gallery or camera
  Future<void> pickImage({bool fromCamera = false}) async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: fromCamera ? ImageSource.camera : ImageSource.gallery,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 85,
      );

      if (image != null) {
        profilePhotoFile = File(image.path);
        update(); // Notify UI
      }
    } catch (e) {
      _showError('Failed to pick image: $e');
    }
  }

  /// Show image picker bottom sheet
  void showImagePickerBottomSheet() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Pilih Foto Profile',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildImagePickerOption(
                  icon: Icons.camera_alt,
                  label: 'Camera',
                  onTap: () {
                    Get.back();
                    pickImage(fromCamera: true);
                  },
                ),
                _buildImagePickerOption(
                  icon: Icons.photo_library,
                  label: 'Gallery',
                  onTap: () {
                    Get.back();
                    pickImage(fromCamera: false);
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildImagePickerOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, size: 32, color: Colors.blue[600]),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Save profile changes
  Future<void> saveProfile() async {
    if (!_validateForm()) return;

    isSaving = true;
    update(); // Notify UI

    try {
      // Update profile menggunakan satu API call untuk semua data
      await _profileService.updateProfile(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        phone: phoneController.text.trim(),
        profileImagePath: profilePhotoFile?.path,
      );

      // Tunggu sebentar agar server selesai proses file upload  
      if (profilePhotoFile != null) {
        await Future.delayed(const Duration(seconds: 2));
      }

      // Show success message
      Get.snackbar(
        'Berhasil',
        'Profile berhasil diperbarui',
        backgroundColor: Colors.green[100],
        colorText: Colors.green[800],
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(16),
        borderRadius: 8,
      );

      // Refresh header profile controller jika ada
      try {
        final headerController = Get.find<HeaderProfileController>();
        await headerController.fetchUserProfile();
      } catch (e) {
        // Header controller mungkin tidak ada, skip
      }

      // Go back to previous screen
      Get.back();

    } catch (e) {
      _showError('Gagal menyimpan profil: $e');
    } finally {
      isSaving = false;
      update(); // Notify UI
    }
  }

  /// Show error message
  void _showError(String message) {
    Get.snackbar(
      'Error',
      message,
      backgroundColor: Colors.red[100],
      colorText: Colors.red[800],
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(16),
      borderRadius: 8,
      duration: const Duration(seconds: 4),
    );
  }

  /// Validate form before saving
  bool _validateForm() {
    if (formKey.currentState?.validate() ?? false) {
      return true;
    }
    return false;
  }

  /// Validate name field
  String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Nama lengkap harus diisi';
    }
    if (value.trim().length < 2) {
      return 'Nama lengkap minimal 2 karakter';
    }
    return null;
  }

  /// Validate email field
  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email harus diisi';
    }
    // Simple email validation
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Format email tidak valid';
    }
    return null;
  }

  /// Validate phone field
  String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Nomor telepon harus diisi';
    }
    // Remove any non-digit characters for validation
    final phoneDigits = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (phoneDigits.length < 10 || phoneDigits.length > 15) {
      return 'Nomor telepon harus 10-15 digit';
    }
    return null;
  }

  /// Helper method untuk konversi aman ke string
  String _safeString(dynamic value) {
    if (value == null) return '';
    return value.toString();
  }
}
