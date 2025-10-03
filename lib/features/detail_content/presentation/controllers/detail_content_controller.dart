import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schoolshare/data/models/publication.dart';
import 'package:schoolshare/features/detail_content/presentation/domain/repositories/detail_content_repository.dart';
// 🔥 Import HomeController agar dapat diakses untuk sinkronisasi
import 'package:schoolshare/features/home/controllers/home_controller.dart';

class DetailContentController extends GetxController {
  final DetailContentRepository repository;

  DetailContentController({required this.repository});

  // State observables
  var isLoading = false.obs;
  var errorMessage = "".obs;
  var publication = Rxn<Publication>();

  // 🔥 Helper Sinkronisasi: Memberi tahu HomeController untuk memperbarui item di listnya
  void _syncWithHomeController(Publication updatedPub) {
    try {
      // Cari instance HomeController yang sudah ada
      final homeController = Get.find<HomeController>();
      homeController.updatePublication(updatedPub);
    } catch (e) {
      // Ini akan terjadi jika HomeController belum diinisialisasi/di-put
      debugPrint("Gagal menemukan HomeController untuk sinkronisasi: $e");
    }
  }

  /// Ambil detail konten berdasarkan [contentId]
  Future<void> loadDetail(String contentId) async {
    try {
      isLoading.value = true;
      errorMessage.value = "";

      final result = await repository.fetchContentDetail(contentId);
      publication.value = result;
    } catch (e) {
      errorMessage.value = e.toString();
      publication.value = null;
    } finally {
      isLoading.value = false;
    }
  }

  // Helper untuk menampilkan Snackbar Error
  void _showErrorSnackbar(String message) {
    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red.shade100,
      colorText: Colors.red.shade800,
    );
  }

  Future<void> toggleBookmark() async {
    final pub = publication.value;
    if (pub == null) return;

    final isCurrentlyBookmarked = pub.isBookmarked;

    // 1. Optimistic Update (Memperbarui UI Detail)
    final updatedPub = pub.copyWith(
      isBookmarked: !isCurrentlyBookmarked,
    );
    publication.value = updatedPub; // Update state detail

    try {
      // 2. Panggil API
      await repository.toggleBookmark(pub.id.toString());

      // 🔥 SINKRONISASI: Beri tahu HomeController tentang perubahan ini
      _syncWithHomeController(updatedPub); // Objek baru disinkronkan

      // ... (Snackbar)
    } catch (e) {
      // 3. Revert jika API gagal
      publication.value = pub; // Revert ke objek awal
      _showErrorSnackbar('Gagal mengubah status simpan: ${e.toString()}');
    }
  }

  // 🔥 LOGIC TOGGLE REKOMENDASI
  Future<void> toggleRecommendation() async {
    final pub = publication.value;
    if (pub == null) return;

    final isCurrentlyRecommended = pub.isRecommended;

    // 1. Optimistic Update
    final updatedPub = pub.copyWith(
      isRecommended: !isCurrentlyRecommended,
      likeCount: pub.likeCount + (!isCurrentlyRecommended ? 1 : -1),
    );
    publication.value = updatedPub; // Update state detail

    try {
      // 2. Panggil API
      await repository.toggleRecommendation(pub.id.toString());

      // 🔥 SINKRONISASI: Beri tahu HomeController tentang perubahan ini
      _syncWithHomeController(updatedPub);

      Get.snackbar('Berhasil', 'Rekomendasi berhasil diperbarui.');
    } catch (e) {
      // 3. Revert jika API gagal
      publication.value = pub; // Revert ke objek awal
      _showErrorSnackbar('Gagal memberi rekomendasi: ${e.toString()}');
    }
  }

  // 🔥 LOGIC DOWNLOAD (Diperbarui untuk menggunakan .copyWith)
  Future<void> handleDownload() async {
    final pub = publication.value;
    if (pub == null || pub.filePath.isEmpty) {
      Get.snackbar('Informasi', 'Dokumen tidak tersedia untuk diunduh.',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    final initialDownloadCount = pub.downloadCount;

    // 1. Optimistic Update metrik
    final updatedPub = pub.copyWith(
      downloadCount: initialDownloadCount + 1,
    );
    publication.value = updatedPub;

    try {
      // 2. Panggil API untuk merekam metrik
      await repository.downloadContent(pub.id.toString());

      // 🔥 SINKRONISASI: Beri tahu HomeController tentang perubahan metrik
      _syncWithHomeController(updatedPub);

      Get.snackbar('Berhasil', 'Proses unduh dicatat dan dimulai.',
          snackPosition: SnackPosition.BOTTOM);

      // TODO: Logika sebenarnya untuk mengelola proses unduhan dokumen di sini
    } catch (e) {
      // 3. Revert jika API gagal
      publication.value = pub; // Revert ke objek awal
      _showErrorSnackbar('Gagal memproses unduhan: ${e.toString()}');
    }
  }

  // 🔥 LOGIC SHARE (Bagikan) (Diperbarui untuk menggunakan .copyWith)
  Future<void> handleShare() async {
    final pub = publication.value;
    if (pub == null) return;

    final initialShareCount = pub.shareCount;

    // 1. Optimistic Update metrik
    final updatedPub = pub.copyWith(
      shareCount: initialShareCount + 1,
    );
    publication.value = updatedPub;

    try {
      // 2. Panggil API untuk merekam metrik
      await repository.shareContent(pub.id.toString());

      // 🔥 SINKRONISASI: Beri tahu HomeController tentang perubahan metrik
      _syncWithHomeController(updatedPub);

      Get.snackbar('Berhasil', 'Konten siap dibagikan.',
          snackPosition: SnackPosition.BOTTOM);

      // TODO: Panggil package share_plus atau logika share native di sini
    } catch (e) {
      // 3. Revert jika API gagal
      publication.value = pub; // Revert ke objek awal
      _showErrorSnackbar('Gagal memproses berbagi: ${e.toString()}');
    }
  }

  /// Untuk reset data (misalnya saat berpindah konten)
  void clearDetail() {
    publication.value = null;
    errorMessage.value = "";
    isLoading.value = false;
  }
}
