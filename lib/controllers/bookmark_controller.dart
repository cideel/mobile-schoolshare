import 'package:get/get.dart';
import '../models/bookmark.dart';
import '../services/bookmark_service.dart';

class BookmarkController extends GetxController {
  final BookmarkService _bookmarkService = BookmarkService();

  // Observable variables
  final RxList<Bookmark> bookmarks = <Bookmark>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool hasError = false.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadBookmarks();
    _listenToBookmarkChanges();
  }

  void _listenToBookmarkChanges() {
    _bookmarkService.bookmarksStream.listen(
      (bookmarkList) {
        bookmarks.value = bookmarkList;
        hasError.value = false;
        errorMessage.value = '';
      },
      onError: (error) {
        hasError.value = true;
        errorMessage.value = error.toString();
      },
    );
  }

  Future<void> loadBookmarks() async {
    try {
      isLoading.value = true;
      hasError.value = false;
      errorMessage.value = '';

      final result = await _bookmarkService.loadBookmarks();
      bookmarks.value = result;
    } catch (e) {
      hasError.value = true;
      errorMessage.value = 'Gagal memuat bookmark: ${e.toString()}';
      
      Get.snackbar(
        'Error',
        'Gagal memuat bookmark',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshBookmarks() async {
    try {
      await _bookmarkService.refreshBookmarks();
      
      Get.snackbar(
        'Berhasil',
        'Bookmark telah diperbarui',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.primary,
        colorText: Get.theme.colorScheme.onPrimary,
        duration: const Duration(seconds: 2),
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal memperbarui bookmark',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
      );
    }
  }

  Future<void> addBookmark(Bookmark bookmark) async {
    try {
      await _bookmarkService.addBookmark(bookmark);
      
      Get.snackbar(
        'Berhasil',
        'Konten berhasil disimpan ke bookmark',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.primary,
        colorText: Get.theme.colorScheme.onPrimary,
        duration: const Duration(seconds: 2),
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal menyimpan bookmark',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
      );
    }
  }

  Future<void> removeBookmark(String bookmarkId) async {
    try {
      await _bookmarkService.removeBookmark(bookmarkId);
      
      Get.snackbar(
        'Berhasil',
        'Bookmark berhasil dihapus',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.primary,
        colorText: Get.theme.colorScheme.onPrimary,
        duration: const Duration(seconds: 2),
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal menghapus bookmark',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
      );
    }
  }

  Future<void> clearAllBookmarks() async {
    try {
      await _bookmarkService.clearAllBookmarks();
      
      Get.snackbar(
        'Berhasil',
        'Semua bookmark berhasil dihapus',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.primary,
        colorText: Get.theme.colorScheme.onPrimary,
        duration: const Duration(seconds: 2),
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal menghapus semua bookmark',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
      );
    }
  }

  Future<bool> isBookmarked(String contentId) async {
    try {
      return await _bookmarkService.isBookmarked(contentId);
    } catch (e) {
      return false;
    }
  }

  int get totalBookmarks => bookmarks.length;

  bool get hasBookmarks => bookmarks.isNotEmpty;

  List<Bookmark> getBookmarksByType(String contentType) {
    return bookmarks.where((bookmark) => bookmark.contentType == contentType).toList();
  }

  List<Bookmark> searchBookmarks(String query) {
    if (query.isEmpty) return bookmarks;

    return bookmarks.where((bookmark) {
      final titleMatch = bookmark.title.toLowerCase().contains(query.toLowerCase());
      final authorMatch = bookmark.authors.any(
        (author) => author.toLowerCase().contains(query.toLowerCase()),
      );
      final typeMatch = bookmark.contentType.toLowerCase().contains(query.toLowerCase());
      
      return titleMatch || authorMatch || typeMatch;
    }).toList();
  }

  @override
  void onClose() {
    _bookmarkService.dispose();
    super.onClose();
  }
}
