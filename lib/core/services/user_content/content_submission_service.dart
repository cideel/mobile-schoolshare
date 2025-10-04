// lib/core/services/user_content/content_submission_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:schoolshare/core/services/api_urls.dart';
import 'package:schoolshare/core/utils/storage_utils.dart';

class ContentSubmissionService {
  /// Submit video content to API
  Future<Map<String, dynamic>> submitVideoContent({
    required String name,
    required String description,
    required String videoUrl,
    required List<String> authorIds,
    Map<String, dynamic> metadata = const {},
  }) async {
    final token = await StorageUtils.getToken();
    
    // Kembali ke regular POST dengan JSON body - match exact database structure
    final requestBody = {
      'name': name,
      'description': description,
      'type': 'video',
      'category': 'user',
      'video_url': videoUrl,
      'file_path': '', // Boleh null untuk video seperti di data example
      'text_content': '', // Boleh null untuk video seperti di data example  
      'metadata': "{}", // String format seperti di data example
    };

    print('🚀 Submitting video content (JSON): $requestBody');

    final response = await http.post(
      Uri.parse(ApiUrls.contentList),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: json.encode(requestBody),
    );

    print('📡 Submit response status: ${response.statusCode}');
    print('📡 Submit response body: ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      final jsonResponse = json.decode(response.body);
      return {
        'success': true,
        'data': jsonResponse['data'],
        'message': jsonResponse['message'] ?? 'Content submitted successfully',
      };
    } else {
      try {
        final errorResponse = json.decode(response.body);
        throw Exception(errorResponse['message'] ?? 'Failed to submit content');
      } catch (e) {
        // If response body is not valid JSON
        throw Exception('Failed to submit content: ${response.statusCode} - ${response.body}');
      }
    }
  }

  /// Generic method untuk submit content (future use)
  Future<Map<String, dynamic>> submitContent({
    required String name,
    required String description,
    required String type,
    String? videoUrl,
    String? filePath,
    required List<String> authorIds,
    Map<String, dynamic> metadata = const {},
    String category = 'user', // Default category
  }) async {
    final token = await StorageUtils.getToken();
    
    // Use multipart request untuk handle array dengan benar
    var request = http.MultipartRequest('POST', Uri.parse(ApiUrls.contentList));
    
    // Add headers
    request.headers.addAll({
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    });

    // Add basic fields (tanpa authors untuk sementara)
    request.fields.addAll({
      'name': name,
      'description': description,
      'type': type,
      'category': category,
      'text_content': '', // Boleh null untuk video seperti di data example
      'file_path': filePath ?? '', // Boleh null untuk video seperti di data example
      'video_url': videoUrl ?? '',
    });

    // Handle metadata - coba approach yang lebih safe
    if (metadata.isNotEmpty) {
      try {
        // Double-encode untuk memastikan backend dapat handle
        final metadataString = json.encode(metadata);
        request.fields['metadata'] = metadataString;
        print('📋 Metadata encoded: $metadataString');
      } catch (e) {
        print('⚠️ Metadata encoding error: $e');
        // Fallback: send empty metadata
        request.fields['metadata'] = '{}';
      }
    } else {
      request.fields['metadata'] = '{}';
    }

    // Add optional fields
    if (videoUrl != null && videoUrl.isNotEmpty) {
      request.fields['video_url'] = videoUrl;
    }
    if (filePath != null && filePath.isNotEmpty) {
      request.fields['file_path'] = filePath;
    }

    // TEMP: Skip authors - biarkan backend set otomatis dari authenticated user
    // Backend kemungkinan belum siap handle authors array dalam pivot table
    // for (int i = 0; i < authorIds.length; i++) {
    //   request.fields['authors[$i]'] = authorIds[i];
    // }

    print('🚀 Submitting content with fields: ${request.fields}');

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    print('📡 Submit response status: ${response.statusCode}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      final jsonResponse = json.decode(response.body);
      return {
        'success': true,
        'data': jsonResponse['data'],
        'message': jsonResponse['message'] ?? 'Content submitted successfully',
      };
    } else {
      try {
        final errorResponse = json.decode(response.body);
        throw Exception(errorResponse['message'] ?? 'Failed to submit content');
      } catch (e) {
        // If response body is not valid JSON
        throw Exception('Failed to submit content: ${response.statusCode} - ${response.body}');
      }
    }
  }
}
