// lib/features/search/domain/repositories/discussion_repository.dart
import 'package:schoolshare/data/models/discussion_item.dart';

abstract class DiscussionRepository {
  Future<List<DiscussionItem>> searchDiscussions({
    required String query,
  });
}
