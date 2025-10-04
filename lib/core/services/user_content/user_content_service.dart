// lib/core/services/user_content/user_content_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:schoolshare/core/services/api_urls.dart';
import 'package:schoolshare/core/utils/storage_utils.dart';
import 'package:schoolshare/data/models/publication.dart';

class UserContentService {
  /// Get user's own uploaded content
  Future<List<Publication>> getUserUploadedContent() async {
    print('🌐 Attempting to fetch user content from API...');
    
    try {
      final token = await StorageUtils.getToken();
      print('🔑 Token retrieved: ${token?.isNotEmpty == true ? "Available" : "Not available"}');
      
      // Menggunakan endpoint contentList dengan filter untuk user sendiri
      // Asumsi: API akan mengembalikan content user berdasarkan token
      final url = Uri.parse('${ApiUrls.contentList}/user');
      print('🔗 Trying endpoint: $url');

      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      print('📡 Response status: ${response.statusCode}');
      print('📡 Response body preview: ${response.body.length > 100 ? response.body.substring(0, 100) + "..." : response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final List<dynamic> data = jsonResponse['data'];
        final publications = data
            .map((json) => Publication.fromJson(json as Map<String, dynamic>))
            .toList();
        print('✅ Successfully loaded ${publications.length} publications from API');
        return publications;
      } else if (response.statusCode == 404) {
        print('⚠️ User endpoint not found, trying fallback...');
        // Jika endpoint tidak ada, coba gunakan endpoint utama dengan parameter
        return await _getUserContentWithFilter();
      } else {
        throw Exception('Failed to load user content: Status ${response.statusCode}, Body: ${response.body}');
      }
    } catch (e) {
      print('❌ API Error: $e');
      // Jika API gagal, coba fallback ke endpoint utama
      try {
        print('🔄 Trying fallback endpoint...');
        return await _getUserContentWithFilter();
      } catch (fallbackError) {
        print('❌ Fallback API Error: $fallbackError');
        // Jika semua API gagal, lempar exception untuk ditangani controller
        throw Exception('All API endpoints failed: Original error: $e, Fallback error: $fallbackError');
      }
    }
  }

  /// Fallback: Get content dengan filter user sendiri
  Future<List<Publication>> _getUserContentWithFilter() async {
    final token = await StorageUtils.getToken();
    
    // Menggunakan endpoint contentList utama dengan parameter filter
    final url = Uri.parse('${ApiUrls.contentList}?filter=own');
    print('🔗 Fallback endpoint: $url');

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    print('📡 Fallback response status: ${response.statusCode}');
    print('📡 Fallback response body preview: ${response.body.length > 100 ? response.body.substring(0, 100) + "..." : response.body}');

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final List<dynamic> data = jsonResponse['data'];
      final publications = data
          .map((json) => Publication.fromJson(json as Map<String, dynamic>))
          .toList();
      print('✅ Successfully loaded ${publications.length} publications from fallback API');
      return publications;
    } else {
      throw Exception('Failed to load user content from fallback: Status ${response.statusCode}, Body: ${response.body}');
    }
  }

  /// Get content statistics for user
  Future<Map<String, dynamic>> getUserContentStats() async {
    final token = await StorageUtils.getToken();
    
    final url = Uri.parse('${ApiUrls.contentList}/user/stats');

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return jsonResponse['data'] as Map<String, dynamic>;
    } else {
      // Return default stats if endpoint not available
      return {
        'total': 0,
        'total_reads': 0,
        'total_downloads': 0,
        'total_likes': 0,
        'total_shares': 0,
        'by_type': {},
      };
    }
  }
}
