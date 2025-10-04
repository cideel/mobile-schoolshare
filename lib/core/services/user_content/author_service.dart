// lib/core/services/user_content/author_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:schoolshare/core/services/api_urls.dart';
import 'package:schoolshare/core/utils/storage_utils.dart';

class AuthorService {
  /// Fetch available authors/users for content submission
  Future<List<Map<String, dynamic>>> getAvailableAuthors({String? query}) async {
    final token = await StorageUtils.getToken();
    
    // Gunakan search endpoint untuk mencari user
    String url = ApiUrls.userSearch;
    if (query != null && query.isNotEmpty) {
      url += '?q=$query';
    }

    print('🔍 Fetching authors from: $url');

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    print('📡 Authors response status: ${response.statusCode}');

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final List<dynamic> data = jsonResponse['data'] ?? [];
      
      final authors = data.map((user) => {
        'id': user['id'].toString(),
        'name': user['name'] ?? 'Unknown',
        'email': user['email'] ?? '',
        'institution': user['institusi']?['name'] ?? 'Unknown Institution',
        'profile': user['profile'] ?? '',
      }).toList();

      print('✅ Loaded ${authors.length} authors');
      return authors;
    } else {
      print('❌ Failed to load authors: ${response.statusCode}');
      throw Exception('Failed to load authors: Status ${response.statusCode}');
    }
  }

  /// Get current user info for auto-selection as author
  Future<Map<String, dynamic>?> getCurrentUser() async {
    final token = await StorageUtils.getToken();
    
    final response = await http.get(
      Uri.parse(ApiUrls.userProfile),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final userData = jsonResponse['data'];
      
      return {
        'id': userData['id'].toString(),
        'name': userData['name'] ?? 'Unknown',
        'email': userData['email'] ?? '',
        'institution': userData['institusi']?['name'] ?? 'Unknown Institution',
        'profile': userData['profile'] ?? '',
      };
    } else {
      print('❌ Failed to get current user: ${response.statusCode}');
      return null;
    }
  }
}
