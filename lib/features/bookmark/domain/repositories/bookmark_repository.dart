import 'package:schoolshare/core/services/bookmark/bookmark_service.dart';
import 'package:schoolshare/core/services/profile/header_profile_services.dart';
import 'package:schoolshare/data/models/bookmark_model.dart';

abstract class BookmarkRepository {
  Future<List<Bookmark>> fetchBookmarks();
  Future<void> toggleBookmark(String contentId);
}

/// Implementasi dari Bookmark Repository.
class BookmarkRepositoryImpl implements BookmarkRepository {
  final BookmarkService _service;
  final HeaderProfileService _profileService;

  BookmarkRepositoryImpl(this._service, this._profileService);

  @override
  Future<List<Bookmark>> fetchBookmarks() async {
    try {
      // Ambil user ID dari profile API
      final profileData = await _profileService.getUserProfile();
      final userId = profileData['id']?.toString();
      
      if (userId == null) {
        throw Exception("User ID tidak ditemukan di profile.");
      }
      
      return await _service.fetchBookmarks(userId);
    } catch (e) {
      // Log error atau konversi ke domain-specific exception jika perlu
      rethrow;
    }
  }

  @override
  Future<void> toggleBookmark(String contentId) async {
    try {
      // Panggil service untuk toggle bookmark
      await _service.toggleBookmark(contentId);
    } catch (e) {
      rethrow;
    }
  }
}
