import 'package:schoolshare/data/models/publication.dart';

abstract class DetailContentRepository {
  Future<Publication> fetchContentDetail(String contentId);

  Future<void> toggleBookmark(String contentId);
  Future<void> toggleRecommendation(String contentId);
  Future<void> shareContent(String contentId);
  Future<void> downloadContent(String contentId);
}
