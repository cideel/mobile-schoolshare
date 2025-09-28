// lib/features/home/controllers/home_controller.dart

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schoolshare/data/models/publication.dart';
import 'package:schoolshare/features/detail_content/presentation/controllers/detail_content_controller.dart';
import '../domain/repositories/home_repository.dart';

class HomeController extends GetxController {
  final HomeRepository _homeRepository = Get.find<HomeRepository>();

  StreamSubscription<Publication>? _realtimeSubscription;

  final RxList<Publication> _publications = <Publication>[].obs;
  final RxList<String> _popularTopics = <String>[].obs;
  final RxBool _isLoading = false.obs;
  final RxString _errorMessage = ''.obs;
  final RxString _searchQuery = ''.obs;

  List<Publication> get publications => _publications;
  bool get isLoading => _isLoading.value;

  @override
  void onInit() {
    super.onInit();
    loadInitialData();
  }

  @override
  void onClose() {
    _realtimeSubscription?.cancel();
    super.onClose();
  }

  Future<void> loadInitialData() async {
    await Future.wait([
      loadPublications(),
      // loadPopularTopics(),
    ]);
  }

  // 🔥 FUNGSI SINKRONISASI KE DETAIL CONTROLLER (Sudah Ada)
  void _syncWithDetailController(Publication updatedPub) {
    final tag = updatedPub.id.toString();
    if (Get.isRegistered<DetailContentController>(tag: tag)) {
      try {
        final detailController = Get.find<DetailContentController>(tag: tag);

        // Memperbarui properti publication di DetailContentController
        // Ini akan memicu Obx di halaman Detail untuk me-rebuild.
        detailController.publication.value = updatedPub
            .copyWith(); // Gunakan copyWith agar objek benar-benar baru
      } catch (e) {
        debugPrint("Gagal menemukan DetailController untuk ID $tag: $e");
      }
    }
  }

  Future<void> loadPublications() async {
    try {
      _isLoading.value = true;
      _errorMessage.value = '';

      final publications = await _homeRepository.getPublications();
      _publications.assignAll(publications);
      _publications.sort((a, b) => b.publishedDate.compareTo(a.publishedDate));
    } catch (e) {
      _errorMessage.value = 'Gagal memuat konten ${e.toString()}';
      _showErrorSnackbar(_errorMessage.value);
    } finally {
      _isLoading.value = false;
    }
  }

  // 🔥 FUNGSI SINKRONISASI DARI DETAIL CONTROLLER (Sudah Benar)
  /// Memperbarui objek Publication yang ada di list Home dengan data terbaru.
  void updatePublication(Publication updatedPub) {
    final index = _publications.indexWhere((p) => p.id == updatedPub.id);

    if (index != -1) {
      // Mengganti objek lama dengan objek baru (dari Detail Content)
      _publications[index] = updatedPub;
      _publications.refresh();
    }
  }

  // Metode untuk menemukan dan memperbarui konten di daftar lokal (Internal Home)
  void _updateLocalPublication(
      Publication pub, Function(Publication) updateFn) {
    final index = _publications.indexWhere((p) => p.id == pub.id);
    if (index != -1) {
      // Memanggil fungsi update pada objek yang dapat dimodifikasi di list
      updateFn(_publications[index]);
      _publications.refresh(); // Memaksa rebuild UI
    }
  }

  // 🔥 LOGIC TOGGLE BOOKMARK (Diperbaiki)
  Future<void> toggleBookmark(Publication publication) async {
    final isCurrentlyBookmarked = publication.isBookmarked;

    try {
      // 1. Panggil API
      await _homeRepository.toggleBookmark(publication.id.toString());

      // 2. Perbarui state lokal Home (Langkah ini memodifikasi objek di _publications)
      _updateLocalPublication(publication, (pub) {
        pub.isBookmarked = !isCurrentlyBookmarked; // Toggle Status
      });

      // 3. 🔥 SINKRONISASI KE DETAIL (Jika Detail sedang terbuka)
      // Ambil objek yang baru saja dimodifikasi dari list Home
      final updatedPub =
          _publications.firstWhere((p) => p.id == publication.id);
      _syncWithDetailController(updatedPub);

      final message =
          !isCurrentlyBookmarked ? 'Konten disimpan!' : 'Simpan dibatalkan.';
      Get.snackbar('Berhasil', message);
    } catch (e) {
      _showErrorSnackbar('Gagal mengubah status simpan: ${e.toString()}');
    }
  }

  // 🔥 LOGIC TOGGLE REKOMENDASI (Diperbaiki)
  Future<void> toggleRecommendation(Publication publication) async {
    final isCurrentlyRecommended = publication.isRecommended;

    try {
      // 1. Panggil API
      await _homeRepository.toggleRecommendation(publication.id.toString());

      // 2. Perbarui state lokal Home
      _updateLocalPublication(publication, (pub) {
        pub.isRecommended = !isCurrentlyRecommended; // Toggle Status
        pub.likeCount += !isCurrentlyRecommended ? 1 : -1; // Perbarui Hitungan
      });

      // 3. 🔥 SINKRONISASI KE DETAIL (Jika Detail sedang terbuka)
      final updatedPub =
          _publications.firstWhere((p) => p.id == publication.id);
      _syncWithDetailController(updatedPub);

      Get.snackbar('Berhasil', 'Rekomendasi berhasil diperbarui.');
    } catch (e) {
      _showErrorSnackbar('Gagal memberi rekomendasi: ${e.toString()}');
    }
  }

  // ... (handleDownload dan method lain tetap sama) ...
  Future<void> handleDownload(Publication publication) async {
    try {
      await _homeRepository.downloadContent(publication.id.toString());
      Get.snackbar('Berhasil', 'Proses unduh dicatat dan dimulai.',
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      _showErrorSnackbar('Gagal memproses unduhan: ${e.toString()}');
    }
  }

  Future<void> handleShare(Publication publication) async {
    try {
      await _homeRepository.shareContent(publication.id.toString());
      Get.snackbar('Berhasil', 'Konten siap dibagikan.',
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      _showErrorSnackbar('Gagal memproses berbagi: ${e.toString()}');
    }
  }

  void _showErrorSnackbar(String message) {
    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red.shade100,
      colorText: Colors.red.shade800,
    );
  }

  Future<void> loadPopularTopics() async {}
  void initializeRealtimeUpdates() {}
  Future<void> refreshData() async {
    await loadInitialData();
  }

  void clearSearch() {
    _searchQuery.value = '';
    loadPublications();
  }

  Publication? getPublicationById(String id) {
    return null;
  }

  void navigateToDetail(Publication publication) {}
}
