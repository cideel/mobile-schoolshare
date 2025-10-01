import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:schoolshare/core/services/api_urls.dart';
import 'package:schoolshare/core/utils/storage_utils.dart'; // Ganti StorageUtils dengan path yang benar
import 'package:schoolshare/data/models/base_search_models.dart';

class SearchRepository {
  final String _peopleUrl = ApiUrls.userSearch;
  final String _publicationUrl = ApiUrls.publicationSearch;
  final String _discussionUrl = ApiUrls.discussionSearch;

  // Helper untuk melakukan request API
  Future<List<T>> _fetchData<T>(String url, String query,
      T Function(Map<String, dynamic>) fromJson) async {
    if (query.isEmpty) return [];

    final token = await StorageUtils.getToken();
    if (token == null) {
      throw Exception('Autentikasi gagal: Token tidak ditemukan.');
    }

    final fullUrl = Uri.parse('$url?q=$query');
    final response = await http.get(
      fullUrl,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      // Asumsi API mengembalikan list data di bawah kunci 'data' atau 'results'
      final List resultsJson = data['data'] ?? data['results'] ?? [];
      return resultsJson.map((json) => fromJson(json)).toList();
    } else {
      throw Exception(
          'Gagal memuat hasil pencarian dari $url. Status: ${response.statusCode}');
    }
  }

  Future<List<UserSearchModel>> searchPeople(String query) async {
    return _fetchData(
        _peopleUrl, query, (json) => UserSearchModel.fromJson(json));
  }

  Future<List<PublicationSearchModel>> searchPublication(String query) async {
    return _fetchData(_publicationUrl, query,
        (json) => PublicationSearchModel.fromJson(json));
  }

  Future<List<DiscussionSearchModel>> searchDiscussion(String query) async {
    return _fetchData(
        _discussionUrl, query, (json) => DiscussionSearchModel.fromJson(json));
  }
}
