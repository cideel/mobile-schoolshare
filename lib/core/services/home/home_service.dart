// lib/core/services/home/home_services.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:schoolshare/core/services/api_urls.dart';
import 'package:schoolshare/core/services/websocket_services.dart';
import 'package:schoolshare/core/utils/storage_utils.dart';
import 'package:schoolshare/data/models/publication.dart';

class HomeServices extends GetxService {
  final WebSocketService wsService = webSocketService;

  // Konstruktor untuk inisialisasi WebSocket saat Service dibuat
  HomeServices() {
    // Hanya inisialisasi jika belum terhubung
    // Ini memastikan kita tidak membuat koneksi ganda jika Service di-lazyPut/di-put
    try {
      wsService.initEcho();
      wsService
          .startContentListener(); // Mulai mendengarkan saat Service dibuat
    } catch (e) {
      print('WebSocket Initialization Error: $e');
    }
  }

  // Fungsi Pengambilan Data HTTP (Initial Load)
  Future<List<Publication>> fetchPublicationsHttp() async {
    final token = await StorageUtils.getToken();

    final url = Uri.parse(ApiUrls.contentList);
    // TODO: Ganti dengan Logic otentikasi aktual Anda
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final List<dynamic> data = jsonResponse['data'];
      return data
          .map((json) => Publication.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Gagal memuat konten: Status ${response.statusCode}');
    }
  }

  // Fungsi Real-Time (WebSocket)
  Stream<Publication> getRealtimeUpdates() {
    // ⚠️ PENTING: Panggil startContentListener di sini saat Stream diminta
    // Ini akan mengirim command SUBSCRIBE ke Reverb.
    wsService.startContentListener();

    // Mengubah Stream<Map<String, dynamic>> dari WS menjadi Stream<Publication> Model
    return wsService.contentStream.map((rawJson) {
      return Publication.fromJson(rawJson);
    });
  }
}
