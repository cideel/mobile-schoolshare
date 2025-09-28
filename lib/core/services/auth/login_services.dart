import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:schoolshare/core/services/api_urls.dart';
import 'package:flutter/material.dart';

class AuthService {
  final http.Client _client;

  // Constructor dengan opsional http.Client untuk pengujian (Dependency Injection)
  AuthService({http.Client? client}) : _client = client ?? http.Client();

  /// Menangani proses Login ke API.
  /// Mengembalikan Map<String, dynamic> yang berisi data respons (JSON).
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse(ApiUrls.login);
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({'email': email, 'password': password});

    try {
      final response = await _client.post(url, headers: headers, body: body);

      // Menggunakan jsonDecode dan pengecekan tipe data yang aman
      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // Asumsi API mengembalikan status 200 dan 'success': true saat berhasil
        if (data['success'] == true && data['user'] != null) {
          return data as Map<String, dynamic>;
        } else {
          // Jika respons 200 tapi isinya menunjukkan kegagalan (logika bisnis)
          throw Exception(
              data['message'] ?? 'Login Gagal. Kredensial tidak valid.');
        }
      } else {
        // Penanganan error HTTP (misalnya 401, 400, 500)
        final errorMessage =
            data['message'] ?? 'Gagal login. Status: ${response.statusCode}';
        throw Exception(errorMessage);
      }
    } on http.ClientException {
      // Penanganan error koneksi atau timeout
      throw Exception(
          'Gagal terhubung ke server. Periksa koneksi atau IP server (${ApiUrls.baseUrl}).');
    } on FormatException {
      // Penanganan jika respons bukan JSON yang valid
      throw Exception('Gagal memproses respons server.');
    } catch (e) {
      // Melempar kembali exception lainnya
      rethrow;
    }
  }

  // -------------------------------------------------------------------

  /// Menangani proses Registrasi ke API.
  /// Mengembalikan Map<String, dynamic> yang berisi data respons (JSON).
  Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String category,
    required int institutionId,
    required bool agreeToTerms,
    required String position,
  }) async {
    final url = Uri.parse(ApiUrls.register);
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      'name': name,
      'email': email,
      'password': password,
      'password_confirmation': confirmPassword,
      'category': category,
      'institusi_id': institutionId.toString(),
      'agree_to_terms': agreeToTerms,
      'position': position,
    });

    try {
      final response = await _client.post(url, headers: headers, body: body);
      final data = jsonDecode(response.body);

      if (response.statusCode == 201 || response.statusCode == 200) {
        if (data['success'] == true && data['user'] != null) {
          return data as Map<String, dynamic>;
        } else {
          throw Exception(data['message'] ?? 'Registrasi Gagal.');
        }
      } else if (response.statusCode >= 400 && response.statusCode < 500) {
        // Penanganan Error Validasi dari sisi server
        String errorMessage =
            data['message'] ?? 'Registrasi gagal. Silakan periksa input Anda.';

        // Ekstraksi pesan error validasi yang lebih rinci (umum pada Laravel/framework lain)
        if (data['errors'] != null && data['errors'] is Map) {
          // Menggabungkan semua pesan error validasi ke dalam satu string
          errorMessage = (data['errors'] as Map)
              .values
              .map((e) => (e as List).join(', '))
              .join('; ');
        }
        throw Exception(errorMessage);
      } else {
        throw Exception(
            'Gagal terhubung ke server. Status: ${response.statusCode}');
      }
    } on http.ClientException {
      throw Exception(
          'Gagal terhubung ke server. Periksa koneksi atau IP server (${ApiUrls.baseUrl}).');
    } on FormatException {
      // Penanganan jika respons bukan JSON yang valid
      throw Exception('Gagal memproses respons server.');
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> addInstitution({
    required String name,
    required String location,
    required String kategori,
  }) async {
    final url = Uri.parse(ApiUrls.addInstitution);
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      'name': name,
      'location': location,
      'kategori': kategori,
    });

    debugPrint('Sending data to API: $body');

    try {
      final response = await _client.post(url, headers: headers, body: body);
      final data = jsonDecode(response.body);

      debugPrint('API Response Status: ${response.statusCode}');
      debugPrint('API Response Body: ${response.body}');

      if (response.statusCode == 201 || response.statusCode == 200) {
        if (data['success'] == true && data['institution'] != null) {
          return data as Map<String, dynamic>;
        } else {
          throw Exception(data['message'] ?? 'Gagal mendaftarkan institusi.');
        }
      } else if (response.statusCode >= 400 && response.statusCode < 500) {
        String errorMessage = data['message'] ??
            'Pendaftaran institusi gagal. Silakan periksa input Anda.';
        if (data['errors'] != null && data['errors'] is Map) {
          errorMessage = (data['errors'] as Map)
              .values
              .map((e) => (e as List).join(', '))
              .join('; ');
        }
        throw Exception(errorMessage);
      } else {
        throw Exception(
            'Gagal terhubung ke server. Status: ${response.statusCode}');
      }
    } on http.ClientException {
      throw Exception(
          'Gagal terhubung ke server. Periksa koneksi atau IP server (${ApiUrls.baseUrl}).');
    } on FormatException {
      throw Exception('Gagal memproses respons server.');
    } catch (e) {
      rethrow;
    }
  }
}
