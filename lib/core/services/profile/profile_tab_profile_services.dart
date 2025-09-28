// lib/core/services/profile_tab_profile_services.dart (Diperbarui)
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:schoolshare/core/services/api_urls.dart';
import 'package:schoolshare/core/utils/storage_utils.dart';
import 'package:schoolshare/data/models/institution_model.dart';
import 'package:schoolshare/data/models/users_model.dart';
import 'package:schoolshare/data/models/position_model.dart';

class ProfileTabProfileServices extends GetxService {
  Future<Map<String, dynamic>> fetchUserProfileRaw() async {
    final token = await StorageUtils.getToken();
    if (token == null || token.isEmpty) {
      throw Exception('Token tidak ditemukan. Sesi berakhir.');
    }

    final url = Uri.parse(ApiUrls.userProfile);
    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else if (response.statusCode == 401) {
        await StorageUtils.clearToken();
        throw Exception('Sesi tidak valid. Silakan login kembali.');
      } else {
        throw Exception('Gagal memuat profil: Status ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan jaringan: $e');
    }
  }

  Institution? getInstitutionFromRawData(Map<String, dynamic> rawData) {
    final instData = rawData['institusi'];
    if (instData != null && instData is Map<String, dynamic>) {
      return Institution.fromJson(instData);
    }
    return null;
  }

  UserModel getUserModelFromRawData(Map<String, dynamic> rawData) {
    return UserModel.fromJson(rawData);
  }

  Position? getPositionFromRawData(Map<String, dynamic> rawData) {
    final posData = rawData['position'];

    if (posData != null && posData is Map<String, dynamic>) {
      return Position.fromJson(posData);
    }
    return null;
  }
}
