// lib/features/discussion/data/repositories/forum_repository_impl.dart (MODIFIED)

import 'package:schoolshare/core/services/forum/forum_service.dart';
import 'package:schoolshare/data/models/comment_item.dart';
import 'package:schoolshare/features/search/presentation/domain/repositories/forum_repository.dart';

class ForumRepositoryImpl implements ForumRepository {
  final ForumService _service;

  ForumRepositoryImpl({required ForumService service}) : _service = service;

  @override
  Future<Map<String, dynamic>> fetchForumDetail(int forumId) async {
    return await _service.fetchForumDetail(forumId);
  }

  @override
  Future<CommentItem> postComment({
    required int forumId,
    required String body,
    int? parentId,
  }) async {
    final commentJson = await _service.postComment(
      forumId: forumId,
      body: body,
      parentId: parentId,
    );

    // ✅ PERBAIKAN UTAMA: Cek jika Map kosong dikembalikan dari service
    if (commentJson.isEmpty) {
      // Jika Map kosong dikembalikan (karena API sukses tapi tidak ada 'data'),
      // kita lemparkan Exception yang akan ditangkap oleh Controller,
      // dan Controller akan tetap menjalankan fetchForumDetail().
      throw Exception(
          "Komentar berhasil dibuat, tetapi data komentar baru (model) tidak dikembalikan oleh API.");
    }

    // Asumsi API store mengembalikan data JSON dengan format yang sama seperti CommentItem.fromJson
    return CommentItem.fromJson(commentJson);
  }
}
