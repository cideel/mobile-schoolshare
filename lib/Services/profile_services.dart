import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:convert';
import 'api_urls.dart';
import 'package:path/path.dart';

class ProfileServices {
  Future<dynamic> getProfile({required String token}) async {
    print('LOG: Mengambil data profil dari URL: ${ApiUrls.getProfile}');
    try {
      final response = await http.get(
        Uri.parse(ApiUrls.getProfile),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      print('LOG: Status Code API: ${response.statusCode}');
      print('LOG: Respons Body API: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('LOG: Data profil berhasil diambil.');
        return data;
      } else {
        throw Exception('Failed to load user profile: ${response.statusCode}');
      }
    } catch (e) {
      print('ERROR: Terjadi kesalahan saat mengambil profil: $e');
      rethrow;
    }
  }

  Future<bool> uploadProfilePicture(
      {required String token, required String imagePath}) async {
    print(
        'LOG: Mengunggah gambar profil ke URL: ${ApiUrls.updatePictureProfile}');
    try {
      final request = http.MultipartRequest(
        'POST', // Mengubah metode dari PUT menjadi POST
        Uri.parse(ApiUrls.updatePictureProfile),
      );

      // Menambahkan header yang sesuai untuk Multipart PUT
      request.headers.addAll({
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      });

      final file = await http.MultipartFile.fromPath(
        'profile', // Nama field sesuai dengan yang dibutuhkan API
        imagePath,
        contentType: MediaType('image', extension(imagePath).substring(1)),
      );

      request.files.add(file);

      final response = await request.send();

      final responseBody = await response.stream.bytesToString();
      print('LOG: Status Code Unggah: ${response.statusCode}');
      print('LOG: Respons Unggah: $responseBody');

      if (response.statusCode == 200) {
        print('LOG: Gambar profil berhasil diunggah.');
        return true;
      } else {
        throw Exception('Gagal mengunggah gambar: ${response.statusCode}');
      }
    } catch (e) {
      print('ERROR: Terjadi kesalahan saat mengunggah gambar: $e');
      rethrow;
    }
  }
}
