// lib/data/repositories/home_repository_impl.dart

import 'package:schoolshare/core/services/home/content_matrix_service.dart';
import 'package:schoolshare/core/services/home/home_service.dart';
import 'package:schoolshare/data/models/publication.dart';
import 'package:schoolshare/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeServices _homeService;
  final ContentMetricsService _metricsService; // Variabel baru

  // 🔥 Konstruktor yang menerima DUA Service
  HomeRepositoryImpl(this._homeService, this._metricsService);

  @override
  Future<List<Publication>> getPublications() async {
    return await _homeService.fetchPublicationsHttp();
  }

  @override
  Stream<Publication> getRealtimeUpdates() {
    return _homeService.getRealtimeUpdates();
  }

  // 🔥 IMPLEMENTASI METRIK
  @override
  Future<void> toggleBookmark(String contentId) async {
    await _metricsService.toggleBookmark(contentId);
  }

  @override
  Future<void> toggleRecommendation(String contentId) async {
    await _metricsService.recommend(contentId);
  }

  @override
  Future<void> shareContent(String contentId) async {
    await _metricsService.share(contentId);
  }

  @override
  Future<void> downloadContent(String contentId) async {
    await _metricsService.download(contentId);
  }

  // --- SIMULASI METHOD LAIN ---
  @override
  Future<List<Publication>> getPublicationsByCategory(String category) async {
    return Future.value([]);
  }

  @override
  Future<List<String>> getCategories() async {
    return ['Semua', 'Artikel', 'Jurnal'];
  }

  @override
  Future<List<String>> getPopularTopics() async {
    return ['Biologi', 'Fisika', 'Matematika'];
  }

  @override
  Future<Publication> getPublicationById(String id) {
    throw UnimplementedError();
  }

  @override
  Future<List<Publication>> searchPublications(String query) {
    throw UnimplementedError();
  }
}
