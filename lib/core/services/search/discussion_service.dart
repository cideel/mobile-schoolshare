// lib/features/search/data/services/discussion_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:schoolshare/core/services/api_urls.dart';
import 'package:schoolshare/core/utils/storage_utils.dart';
import 'package:flutter/material.dart'; // Tambahkan ini untuk debugPrint

class DiscussionService {
  final http.Client _client;

  DiscussionService({http.Client? client}) : _client = client ?? http.Client();

  Future<List<Map<String, dynamic>>> searchDiscussions({
    required String query,
  }) async {
    final url = Uri.parse(
        '${ApiUrls.discussionSearch}?q=${Uri.encodeComponent(query)}');

    final token = await StorageUtils.getToken();
    if (token == null) {
      throw Exception('Autentikasi gagal. Token tidak ditemukan.');
    }

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    debugPrint('➡️ API Request: GET $url');

    try {
      final response = await _client.get(url, headers: headers);

      // ✅ Log Response Status dan Body
      debugPrint('⬅️ API Response Status: ${response.statusCode}');
      debugPrint('⬅️ API Response Body Length: ${response.body.length}');

      // Jika body kosong atau sangat pendek, itu masalah format
      if (response.body.isEmpty || response.body.trim().isEmpty) {
        debugPrint('⚠️ WARNING: Response body is empty.');
        // Jika status non-200, throw error yang lebih spesifik
        if (response.statusCode != 200) {
          throw Exception(
              'Server mengembalikan status ${response.statusCode}, namun body respons kosong.');
        }
        // Jika status 200 dengan body kosong, anggap list kosong.
        return [];
      }

      // Coba decode JSON
      final Map<String, dynamic> responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (responseData['success'] == true &&
            responseData.containsKey('data') &&
            responseData['data'] is List) {
          debugPrint(
              '✅ JSON Decode Success. ${responseData['data'].length} item ditemukan.');
          return List<Map<String, dynamic>>.from(responseData['data']);
        }

        // Jika respons 200 tapi 'success' false
        final errorMessage = responseData['message'] ??
            'Pencarian diskusi gagal (Logika Server).';
        debugPrint('❌ API Status 200 but Logic Fail: $errorMessage');
        throw Exception(errorMessage);
      } else {
        // Penanganan error HTTP non-200
        final errorMessage = responseData['message'] ??
            'Gagal mencari diskusi. Status: ${response.statusCode}';
        debugPrint(
            '❌ HTTP Status Error: ${response.statusCode} - $errorMessage');
        throw Exception(errorMessage);
      }
    } on http.ClientException {
      debugPrint('❌ CONNECTION ERROR: Gagal terhubung.');
      throw Exception('Gagal terhubung ke server. Periksa koneksi Anda.');
    } on FormatException catch (e) {
      // ✅ Tampilkan body yang gagal di-decode
      debugPrint('❌ JSON PARSING ERROR: Gagal memproses JSON. Error: $e');
      // Karena kita tidak memiliki 'response' di scope ini, Anda harus menangkapnya secara spesifik.
      // Coba jalankan kode dengan log di atas, dan lihat "Response Body Length" di log.
      throw Exception('Gagal memproses respons server.');
    } catch (e) {
      debugPrint('❌ UNKNOWN ERROR: $e');
      rethrow;
    }
  }
}
