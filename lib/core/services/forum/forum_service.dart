// lib/features/discussion/data/services/forum_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:schoolshare/core/services/api_urls.dart';
import 'package:schoolshare/core/utils/storage_utils.dart';
import 'package:flutter/material.dart';

class ForumService {
  final http.Client _client;

  ForumService({http.Client? client}) : _client = client ?? http.Client();

  Future<Map<String, dynamic>> _sendAuthorizedRequest(
    String method,
    Uri url, {
    Map<String, String>? headers,
    Object? body,
  }) async {
    final token = await StorageUtils.getToken();
    if (token == null) {
      throw Exception('Autentikasi gagal. Token tidak ditemukan.');
    }

    final defaultHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
      ...(headers ?? {}),
    };

    http.Response response;

    debugPrint('➡️ API Request: $method $url');

    try {
      if (method == 'GET') {
        response = await _client.get(url, headers: defaultHeaders);
        debugPrint('⬅️ API Response Status: ${response.statusCode}');

        // ✅ TAMBAHKAN INI UNTUK MELIHAT RAW BODY
        debugPrint(
            '⬅️ RAW BODY (100 chars): ${response.body.substring(0, response.body.length > 100 ? 100 : response.body.length)}');
      } else if (method == 'POST') {
        response = await _client.post(url, headers: defaultHeaders, body: body);
        debugPrint('⬅️ API Response Status: ${response.statusCode}');

        // ✅ TAMBAHKAN INI UNTUK MELIHAT RAW BODY
        debugPrint(
            '⬅️ RAW BODY (100 chars): ${response.body.substring(0, response.body.length > 100 ? 100 : response.body.length)}');
      } else {
        throw UnsupportedError('Method $method not supported');
      }

      debugPrint('⬅️ API Response Status: ${response.statusCode}');

      // 1. Tangani respons kosong (empty body)
      if (response.body.isEmpty) {
        if (response.statusCode == 204 || response.statusCode == 201) {
          // Sukses tapi body kosong, kembalikan Map yang valid.
          return {'success': true, 'message': 'Operasi berhasil.'};
        }
        // Jika status lain (misalnya 200) tapi body kosong, lempar error.
        throw Exception(
            'Server mengembalikan respons kosong (Status: ${response.statusCode}).');
      }

      // 2. Amankan dari jsonDecode yang mengembalikan null atau tipe selain Map
      final dynamic decodedData = jsonDecode(response.body);

      if (decodedData == null || decodedData is! Map<String, dynamic>) {
        // Ini akan menangani jika body adalah string 'null', array, atau tipe non-Map lainnya.
        throw Exception(
            'Respons server tidak valid. Diharapkan JSON Map, tetapi mendapat tipe ${decodedData.runtimeType}.');
      }

      final responseData = decodedData as Map<String, dynamic>;

      // 3. Penanganan HTTP Status dan Logic Success
      if (response.statusCode >= 200 && response.statusCode < 300) {
        // Asumsi server mengembalikan {'success': true, 'data': ...}
        if (responseData['success'] == true) {
          return responseData;
        } else {
          // Response 2xx tapi success: false (Business Logic Error)
          throw Exception(
              responseData['message'] ?? 'Permintaan gagal (Logika Server).');
        }
      } else {
        // HTTP Error (4xx, 5xx)
        throw Exception(responseData['message'] ??
            'Server error. Status: ${response.statusCode}');
      }
    } on http.ClientException {
      throw Exception('Gagal terhubung ke server. Periksa koneksi Anda.');
    } on FormatException {
      // Ini menangkap error saat response.body tidak valid JSON
      throw Exception('Gagal memproses respons server. Format tidak valid.');
    } catch (e) {
      rethrow;
    }
  }

  // ----------------------------------------------------
  // PUBLIC METHODS
  // ----------------------------------------------------

  /// Mengambil detail forum dan komentarnya
  Future<Map<String, dynamic>> fetchForumDetail(int forumId) async {
    final url = Uri.parse(ApiUrls.forumDetail(forumId));
    final responseData = await _sendAuthorizedRequest('GET', url);
    return responseData['data']
        as Map<String, dynamic>; // Ambil langsung kunci 'data'
  }

  /// Mengirim komentar baru ke forum
  Future<Map<String, dynamic>> postComment({
    required int forumId,
    required String body,
    int? parentId,
  }) async {
    final url = Uri.parse(ApiUrls.storeComment(forumId));
    final bodyData = jsonEncode({
      'body': body,
      'parent_id': parentId, // Bisa null untuk komentar utama
    });
    final responseData =
        await _sendAuthorizedRequest('POST', url, body: bodyData);

    // Output Postman Anda menunjukkan 'data' ada, tetapi jika API secara inkonsisten
    // mengembalikannya sebagai null, Map kosong akan dikembalikan di sini.
    if (responseData.containsKey('data') && responseData['data'] != null) {
      return responseData['data'] as Map<String, dynamic>;
    }

    // Jika 'data' tidak ada, kembalikan Map kosong.
    // Ini akan ditangkap sebagai Exception di Repository.
    return {};
  }

  Future<List<Map<String, dynamic>>> fetchCategories() async {
    final url = Uri.parse(ApiUrls.listCategories);
    final responseData = await _sendAuthorizedRequest('GET', url);
    // Asumsi 'data' adalah List<Map<String, dynamic>>
    return (responseData['data'] as List).cast<Map<String, dynamic>>();
  }

  /// Membuat diskusi (forum) baru dengan kategori yang sudah ada atau baru
  Future<Map<String, dynamic>> createForum({
    int? categoryId, // ID kategori yang sudah ada (bisa null)
    String? newCategoryName, // Nama kategori baru (bisa null)
    required String title,
    required String body,
  }) async {
    final url = Uri.parse(ApiUrls.createForum);

    // Siapkan body data sesuai dengan validasi API Laravel
    final Map<String, dynamic> data = {
      'title': title,
      'body': body,
    };

    // Tambahkan hanya salah satu parameter kategori yang diperlukan
    if (categoryId != null) {
      data['category_id'] = categoryId;
    } else if (newCategoryName != null) {
      data['new_category_name'] = newCategoryName;
    } else {
      // Ini harusnya dicegah di Controller/Repository
      throw Exception('Harus memilih kategori atau membuat kategori baru.');
    }

    final bodyData = jsonEncode(data);

    final responseData =
        await _sendAuthorizedRequest('POST', url, body: bodyData);

    if (responseData.containsKey('data') && responseData['data'] != null) {
      return responseData['data'] as Map<String, dynamic>;
    }

    return {};
  }
}
