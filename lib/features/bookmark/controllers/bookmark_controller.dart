import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schoolshare/data/models/bookmark_model.dart';
import 'package:schoolshare/features/bookmark/domain/repositories/bookmark_repository.dart';

class BookmarkController extends GetxController {
  final BookmarkRepository _repository;

  // Observable State
  final isLoading = true.obs;
  final hasError = false.obs;
  final bookmarks = <Bookmark>[].obs;

  BookmarkController(this._repository);

  @override
  void onInit() {
    fetchBookmarks();
    super.onInit();
  }

  /// Memuat daftar bookmark dari repository.
  Future<void> fetchBookmarks() async {
    isLoading.value = true;
    hasError.value = false;
    try {
      final result = await _repository.fetchBookmarks();
      bookmarks.assignAll(result);
    } catch (e) {
      print("Error fetching bookmarks: $e");
      hasError.value = true;
    } finally {
      isLoading.value = false;
    }
  }

  /// Logika untuk menghapus/toggle bookmark
  Future<void> toggleBookmark(int contentId) async {
    try {
      // Konversi contentId ke String
      final contentIdStr = contentId.toString();
      
      // Panggil repository untuk toggle bookmark
      await _repository.toggleBookmark(contentIdStr);
      
      // Refresh daftar bookmark setelah toggle
      await fetchBookmarks();
      
      // Tampilkan pesan sukses
      Get.snackbar(
        'Berhasil',
        'Bookmark berhasil dihapus',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.primary,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
    } catch (e) {
      // Tampilkan pesan error
      print("Error toggling bookmark: $e");
      Get.snackbar(
        'Error',
        'Gagal menghapus bookmark: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
    }
  }

  /// Aksi saat tombol coba lagi (Retry) di error state ditekan.
  void retryFetch() {
    fetchBookmarks();
  }
}
