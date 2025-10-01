import 'dart:convert';

import 'package:schoolshare/core/services/api_urls.dart';
import 'package:http/http.dart' as http;
import 'package:schoolshare/core/utils/storage_utils.dart';
import 'package:schoolshare/data/models/bookmark_model.dart';

class BookmarkService {
  final http.Client _httpClient = http.Client();

  /// Mengambil daftar bookmark dari API.
  Future<List<Bookmark>> fetchBookmarks(String userId) async {
    try {
      final String url = ApiUrls.bookmarkList(userId);
      final String? token = await StorageUtils.getToken();

      if (token == null) {
        throw Exception("Token autentikasi tidak ditemukan.");
      }

      final response = await _httpClient.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse =
            json.decode(response.body) as Map<String, dynamic>;
        final BookmarkListResponse apiResponse =
            BookmarkListResponse.fromJson(jsonResponse);
        return apiResponse.data;
      } else {
        // Handle error response from server
        final errorBody = json.decode(response.body);
        final errorMessage = errorBody['message'] ?? 'Gagal memuat bookmark.';
        throw Exception("Status code ${response.statusCode}: $errorMessage");
      }
    } catch (e) {
      // Re-throw exception untuk di-handle oleh Repository/Controller
      rethrow;
    }
  }
}
