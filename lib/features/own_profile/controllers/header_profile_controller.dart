import 'package:flutter/material.dart'; // untuk debugPrint
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:schoolshare/features/own_profile/domain/repositories/header_profile_repository.dart';

class HeaderProfileController extends GetxController {
  final HeaderProfileRepository _repository;
  final ImagePicker _picker = ImagePicker();

  HeaderProfileController({required HeaderProfileRepository repository})
      : _repository = repository;

  // Rx variables untuk menyimpan state yang reaktif
  final RxBool isLoading = true.obs;
  final Rx<Map<String, dynamic>> userProfile = Rx<Map<String, dynamic>>({});
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final profileData = await _repository.getUserProfile();
      userProfile.value = profileData;

      debugPrint('User profile loaded: ${userProfile.value}');
    } catch (e) {
      debugPrint('Failed to fetch user profile: $e');
      errorMessage.value = e.toString().replaceAll('Exception: ', '');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> pickAndUploadProfilePicture() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      try {
        // Notifikasi proses unggah
        Get.snackbar(
          'Proses Unggah',
          'Mengunggah foto profil baru...',
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 5),
          showProgressIndicator: true,
        );

        // 1. Panggil service untuk mengunggah file
        await _repository.updateProfilePicture(image.path);

        // 2. Refresh data profil untuk menampilkan gambar baru
        // Kita paksa loading untuk memastikan tampilan gambar diperbarui
        isLoading.value = true;
        
        // Tunggu sebentar agar server selesai proses file upload
        await Future.delayed(const Duration(seconds: 2));
        
        await fetchUserProfile();
        // Force UI rebuild
        update();

        // Notifikasi sukses
        Get.snackbar('Berhasil', 'Foto profil berhasil diperbarui.',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green.shade700,
            colorText: Colors.white);
      } catch (e) {
        debugPrint('Upload failed: $e');
        Get.snackbar('Gagal Unggah', e.toString().replaceAll('Exception: ', ''),
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red.shade700,
            colorText: Colors.white);
      }
    } else {
      // Notifikasi pembatalan
      Get.snackbar(
        'Dibatalkan',
        'Pemilihan gambar dibatalkan.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
