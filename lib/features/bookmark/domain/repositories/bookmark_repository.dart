import 'package:schoolshare/core/services/bookmark/bookmark_service.dart';
import 'package:schoolshare/core/utils/storage_utils.dart';
import 'package:schoolshare/data/models/bookmark_model.dart';

abstract class BookmarkRepository {
  Future<List<Bookmark>> fetchBookmarks();
}

/// Implementasi dari Bookmark Repository.
class BookmarkRepositoryImpl implements BookmarkRepository {
  final BookmarkService _service;

  BookmarkRepositoryImpl(this._service);

  @override
  Future<List<Bookmark>> fetchBookmarks() async {
    try {
      final String? userId = await StorageUtils.getToken();
      if (userId == null) {
        throw Exception("User ID tidak ditemukan.");
      }
      return await _service.fetchBookmarks(userId);
    } catch (e) {
      // Log error atau konversi ke domain-specific exception jika perlu
      rethrow;
    }
  }
}
