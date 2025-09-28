// lib/core/services/content_metrics_service.dart
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';
import 'package:schoolshare/core/services/api_urls.dart';
import 'package:schoolshare/core/utils/storage_utils.dart';

class ContentMetricsService extends GetxService {
  Future<Map<String, String>> _getAuthHeaders(
      {bool withJsonContentType = true}) async {
    final token = await StorageUtils.getToken();

    if (token == null || token.isEmpty) {
      throw Exception("Authentication token not found.");
    }

    final Map<String, String> headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    };

    if (withJsonContentType) {
      headers['Content-Type'] = 'application/json';
    } else {
      headers.remove('Content-Type');
    }

    return headers;
  }

  // --- 1. POST Request Sederhana (Recommend, Share, Download) ---
  Future<void> _postSimpleMetrics(String url) async {
    try {
      final headers = await _getAuthHeaders(withJsonContentType: false);

      final response = await http.post(
        Uri.parse(url),
        headers: headers,
      );

      if (response.statusCode != 200) {
        throw Exception('API error with status: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error Koneksi', 'Gagal memperbarui metrik: ${e.toString()}',
          snackPosition: SnackPosition.BOTTOM);
      rethrow;
    }
  }

  // 🔥 Recommend/Like
  Future<void> recommend(String contentId) async {
    await _postSimpleMetrics(ApiUrls.recommendContent(contentId));
  }

  // 🔥 Share
  Future<void> share(String contentId) async {
    await _postSimpleMetrics(ApiUrls.shareContent(contentId));
  }

  // 🔥 Download
  Future<void> download(String contentId) async {
    await _postSimpleMetrics(ApiUrls.downloadContent(contentId));
  }

  // --- 2. POST Request dengan Body (Bookmark) ---
  Future<void> toggleBookmark(String contentId) async {
    try {
      final headers = await _getAuthHeaders(withJsonContentType: true);

      final response = await http.post(
        Uri.parse(ApiUrls.toggleBookmark),
        headers: headers,
        body: json.encode({
          'content_id': contentId,
        }),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception('API error with status: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error Koneksi', 'Gagal toggle bookmark: ${e.toString()}',
          snackPosition: SnackPosition.BOTTOM);
      rethrow;
    }
  }
}
