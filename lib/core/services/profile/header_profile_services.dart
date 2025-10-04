import 'dart:convert';
import 'package:flutter/foundation.dart'; // Digunakan untuk debugPrint
import 'package:http/http.dart' as http;
import 'package:schoolshare/core/services/api_urls.dart';
import 'package:schoolshare/core/utils/storage_utils.dart';
import 'package:schoolshare/features/own_profile/domain/repositories/header_profile_repository.dart';

class HeaderProfileService implements HeaderProfileRepository {
  final http.Client _client;

  HeaderProfileService({http.Client? client})
      : _client = client ?? http.Client();

  @override
  Future<Map<String, dynamic>> getUserProfile() async {
    final String? token = await StorageUtils.getToken();

    if (token == null) {
      throw Exception(
          'Token autentikasi tidak ditemukan. Silakan login kembali.');
    }

    final url = Uri.parse(ApiUrls.userProfile);
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    debugPrint('Fetching user profile from: $url');

    try {
      final response = await _client.get(url, headers: headers);
      final data = json.decode(response.body);

      debugPrint('API response status: ${response.statusCode}');
      debugPrint('API response body: ${response.body}');

      if (response.statusCode == 200) {
        return data as Map<String, dynamic>;
      } else if (response.statusCode == 401) {
        throw Exception('Sesi habis. Silakan login kembali.');
      } else {
        throw Exception(data['message'] ??
            'Gagal memuat profil: Status ${response.statusCode}');
      }
    } on http.ClientException {
      throw Exception(
          'Gagal terhubung ke server. Periksa koneksi atau IP server (${ApiUrls.baseUrl}).');
    } catch (e) {
      debugPrint('Error in getUserProfile: $e');
      rethrow;
    }
  }

  Future<void> updateProfilePicture(String filePath) async {
    final String? token = await StorageUtils.getToken();

    if (token == null) {
      throw Exception(
          'Token autentikasi tidak ditemukan. Silakan login kembali.');
    }

    final url = Uri.parse(ApiUrls.updateProfile);

    // Menggunakan MultipartRequest untuk upload file
    final request = http.MultipartRequest('POST', url)
      ..headers['Authorization'] = 'Bearer $token'
      // Menambahkan file yang dipilih dengan field 'profile'
      ..files.add(await http.MultipartFile.fromPath('profile', filePath));

    // Catatan: Jika API update menggunakan PUT/PATCH, tambahkan:
    // request.fields['_method'] = 'PUT';

    debugPrint('Uploading profile picture to: $url');

    try {
      final streamedResponse = await _client.send(request);
      final response = await http.Response.fromStream(streamedResponse);
      final data = json.decode(response.body);

      debugPrint('Upload response status: ${response.statusCode}');
      debugPrint('Upload response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Sukses. Notifikasi akan ditampilkan di Controller.
      } else if (response.statusCode == 401) {
        throw Exception('Sesi habis. Silakan login kembali.');
      } else {
        throw Exception(data['message'] ??
            'Gagal memperbarui foto profil: Status ${response.statusCode}');
      }
    } on http.ClientException {
      throw Exception(
          'Gagal terhubung ke server saat upload. Periksa koneksi atau IP server (${ApiUrls.baseUrl}).');
    } catch (e) {
      debugPrint('Error in updateProfilePicture: $e');
      rethrow;
    }
  }

  Future<void> updateProfile({
    String? name,
    String? email,
    String? phone,
    String? profileImagePath,
  }) async {
    final String? token = await StorageUtils.getToken();

    if (token == null) {
      throw Exception(
          'Token autentikasi tidak ditemukan. Silakan login kembali.');
    }

    final url = Uri.parse(ApiUrls.updateProfile);

    // Menggunakan MultipartRequest untuk support file upload dan data
    final request = http.MultipartRequest('POST', url)
      ..headers['Authorization'] = 'Bearer $token';

    // Tambahkan data text fields
    if (name != null && name.isNotEmpty) {
      request.fields['name'] = name;
    }
    if (email != null && email.isNotEmpty) {
      request.fields['email'] = email;
    }
    if (phone != null && phone.isNotEmpty) {
      request.fields['phone'] = phone;
    }

    // Tambahkan file jika ada
    if (profileImagePath != null && profileImagePath.isNotEmpty) {
      request.files.add(await http.MultipartFile.fromPath('profile', profileImagePath));
    }

    debugPrint('Updating profile to: $url');
    debugPrint('Fields: ${request.fields}');
    debugPrint('Has file: ${request.files.isNotEmpty}');

    try {
      final streamedResponse = await _client.send(request);
      final response = await http.Response.fromStream(streamedResponse);
      final responseData = json.decode(response.body);

      debugPrint('Update profile response status: ${response.statusCode}');
      debugPrint('Update profile response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Sukses. Notifikasi akan ditampilkan di Controller.
      } else if (response.statusCode == 401) {
        throw Exception('Sesi habis. Silakan login kembali.');
      } else {
        throw Exception(responseData['message'] ??
            'Gagal memperbarui profil: Status ${response.statusCode}');
      }
    } on http.ClientException {
      throw Exception(
          'Gagal terhubung ke server. Periksa koneksi atau IP server (${ApiUrls.baseUrl}).');
    } catch (e) {
      debugPrint('Error in updateProfile: $e');
      rethrow;
    }
  }
}
