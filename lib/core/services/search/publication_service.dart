import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:schoolshare/core/services/api_urls.dart';
import 'package:schoolshare/core/utils/storage_utils.dart';
import 'package:schoolshare/data/models/publication.dart';

class PublicationService {
  Future<List<Publication>> searchPublications({String? query}) async {
    final token = await StorageUtils.getToken();
    final url = query == null || query.isEmpty
        ? Uri.parse(ApiUrls.publicationSearch)
        : Uri.parse("${ApiUrls.publicationSearch}?q=$query");

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
      return data.map((e) => Publication.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load publications");
    }
  }
}
