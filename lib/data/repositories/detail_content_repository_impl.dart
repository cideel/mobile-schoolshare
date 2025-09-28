// lib/data/repositories/detail_content_repository_impl.dart

import 'package:schoolshare/core/services/home/detail_content_services.dart';
import 'package:schoolshare/data/models/publication.dart';
import 'package:schoolshare/features/detail_content/presentation/domain/repositories/detail_content_repository.dart';

class DetailContentRepositoryImpl implements DetailContentRepository {
  final DetailContentService service;

  DetailContentRepositoryImpl({required this.service});

  @override
  Future<Publication> fetchContentDetail(String contentId) {
    // Mendelegasikan permintaan detail ke service
    return service.fetchContentDetail(contentId);
  }

  @override
  Future<void> toggleBookmark(String contentId) {
    // Mendelegasikan aksi bookmark ke service
    return service.toggleBookmark(contentId);
  }

  @override
  Future<void> toggleRecommendation(String contentId) {
    // Mendelegasikan aksi rekomendasi ke service
    return service.recommend(contentId);
  }

  @override
  Future<void> shareContent(String contentId) {
    // Mendelegasikan aksi share ke service
    return service.share(contentId);
  }

  @override
  Future<void> downloadContent(String contentId) {
    // Mendelegasikan aksi download ke service
    return service.download(contentId);
  }
}
