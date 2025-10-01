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

  /// Logika untuk menghapus/toggle bookmark (contoh)
  Future<void> toggleBookmark(int contentId) async {
    // Implementasi logika API toggleBookmark di sini
    // Setelah sukses, panggil fetchBookmarks() untuk me-refresh list
    // Misalnya:
    // try {
    //   await _service.toggleBookmark(contentId);
    //   fetchBookmarks();
    // } catch (e) {
    //   Get.snackbar('Error', 'Gagal mengubah status bookmark');
    // }
  }

  /// Aksi saat tombol coba lagi (Retry) di error state ditekan.
  void retryFetch() {
    fetchBookmarks();
  }
}
