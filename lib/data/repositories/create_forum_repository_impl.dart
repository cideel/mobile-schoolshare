// lib/features/discussion/data/repositories/create_forum_repository_impl.dart (FINAL REVISION)

import 'package:schoolshare/data/models/discussion_item.dart';
import 'package:schoolshare/core/services/forum/forum_service.dart';
import 'package:schoolshare/features/search/presentation/domain/repositories/create_forum_repository.dart';

class CreateForumRepositoryImpl implements CreateForumRepository {
  final ForumService _service;

  CreateForumRepositoryImpl({required ForumService service})
      : _service = service;

  @override
  Future<List<DiscussionCategory>> fetchCategories() async {
    final categoriesJson = await _service.fetchCategories();

    // Urutkan kategori berdasarkan forums_count secara descending (paling populer di atas)
    categoriesJson.sort((a, b) =>
        (b['forums_count'] as num).compareTo(a['forums_count'] as num));

    // Map JSON ke DiscussionCategory model
    return categoriesJson
        .map((json) => DiscussionCategory.fromJson(json))
        .toList();
  }

  @override
  Future<DiscussionItem> createForum({
    int? categoryId,
    String? newCategoryName,
    required String title,
    required String body,
  }) async {
    final forumJson = await _service.createForum(
      categoryId: categoryId,
      newCategoryName: newCategoryName,
      title: title,
      body: body,
    );

    if (forumJson.isEmpty) {
      throw Exception(
          "Diskusi berhasil dibuat, tetapi data forum baru (model) tidak dikembalikan oleh API.");
    }

    // Asumsi API store forum mengembalikan model DiscussionItem lengkap
    // Catatan: Karena respons API store di Laravel Anda mengembalikan model Forum,
    // pastikan model tersebut memiliki relasi 'user' dan 'category' yang dimuat,
    // jika tidak, DiscussionItem.fromJson akan gagal.
    return DiscussionItem.fromJson(forumJson);
  }
}
