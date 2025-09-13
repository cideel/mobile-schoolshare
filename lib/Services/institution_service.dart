// lib/services/institution_service.dart

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'api_urls.dart';

class InstitutionService {
  Future<List<dynamic>> getInstitutions() async {
    print('LOG: Mengambil data institusi dari URL: ${ApiUrls.getInstitusion}');
    try {
      final response = await http.get(
        Uri.parse(ApiUrls.getInstitusion),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      print('LOG: Status Code API: ${response.statusCode}');
      print('LOG: Respons Body API: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(
            'LOG: Data institusi berhasil diambil. Jumlah: ${data['data'].length}');
        return data['data'];
      } else {
        throw Exception('Failed to load institutions: ${response.statusCode}');
      }
    } catch (e) {
      print('ERROR: Terjadi kesalahan saat mengambil institusi: $e');
      rethrow;
    }
  }

  Future<dynamic> addInstitution({
    required String name,
    required String location,
    required String kategori,
  }) async {
    print('LOG: Menambahkan institusi ke URL: ${ApiUrls.addInstitusion}');
    try {
      final response = await http.post(
        Uri.parse(ApiUrls.addInstitusion),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'name': name,
          'location': location,
          'kategori': kategori,
        }),
      );

      print('LOG: Status Code API: ${response.statusCode}');
      print('LOG: Respons Body API: ${response.body}');

      return jsonDecode(response.body);
    } catch (e) {
      print('ERROR: Terjadi kesalahan saat menambahkan institusi: $e');
      rethrow;
    }
  }
}
