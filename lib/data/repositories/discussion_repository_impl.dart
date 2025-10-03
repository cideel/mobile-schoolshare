// lib/features/search/data/repositories/discussion_repository_impl.dart

import 'package:schoolshare/core/services/search/discussion_service.dart';
import 'package:schoolshare/data/models/discussion_item.dart';
import 'package:schoolshare/features/search/presentation/domain/repositories/discussion_repository.dart';

class DiscussionRepositoryImpl implements DiscussionRepository {
  final DiscussionService _discussionService;

  DiscussionRepositoryImpl({DiscussionService? discussionService})
      : _discussionService = discussionService ?? DiscussionService();

  @override
  Future<List<DiscussionItem>> searchDiscussions({
    required String query,
  }) async {
    try {
      final dataList = await _discussionService.searchDiscussions(query: query);

      return dataList.map((json) => DiscussionItem.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
