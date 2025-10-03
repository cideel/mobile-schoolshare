// lib/features/discussion/domain/repositories/forum_repository.dart


import 'package:schoolshare/data/models/comment_item.dart';

abstract class ForumRepository {
  Future<Map<String, dynamic>> fetchForumDetail(int forumId);
  Future<CommentItem> postComment({
    required int forumId,
    required String body,
    int? parentId,
  });
}