// lib/services/home_service.dart

import 'package:http/http.dart' as http;
import 'package:schoolshare/Models/content.dart';
import 'package:schoolshare/Services/api_urls.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class HomeServices {
  Future<List<Content>> getContents() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');

    if (token == null) {
      throw Exception('Token otentikasi tidak ditemukan.');
    }

    final response = await http.get(
      Uri.parse(ApiUrls.getHome),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      final List<dynamic> contentData = jsonResponse['data'];

      // Mengubah list JSON menjadi list objek Content
      return contentData.map((json) => Content.fromJson(json)).toList();
    } else {
      // Melemparkan exception dengan pesan error yang spesifik
      throw Exception(
          'Gagal memuat konten. Kode status: ${response.statusCode}');
    }
  }
}
