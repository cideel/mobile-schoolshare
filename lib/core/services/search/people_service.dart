import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:schoolshare/core/services/api_urls.dart';
import 'package:schoolshare/core/utils/storage_utils.dart';

class PeopleService {
  /// Cari user dengan query
  Future<List<Map<String, dynamic>>> searchUsers({String? query}) async {
    final token = await StorageUtils.getToken();

    final url = query == null || query.isEmpty
        ? Uri.parse(ApiUrls.userSearch)
        : Uri.parse("${ApiUrls.userSearch}?q=$query");

    final response = await http.get(
      url,
      headers: {
        "Authorization": "Bearer $token",
        "Accept": "application/json",
      },
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final List data = jsonData["data"];
      // kembalikan sebagai list map, repository nanti bisa convert ke model
      return List<Map<String, dynamic>>.from(data);
    } else {
      throw Exception("Failed to load users");
    }
  }
}
