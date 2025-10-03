// lib/features/discussion/domain/repositories/create_forum_repository.dart (MODIFIED)

import 'package:schoolshare/data/models/discussion_item.dart';

abstract class CreateForumRepository {
  /// Mengambil daftar kategori untuk dipilih
  Future<List<DiscussionCategory>> fetchCategories();

  /// Membuat forum baru
  Future<DiscussionItem> createForum({
    int? categoryId, // Bisa null jika membuat kategori baru
    String? newCategoryName, // Bisa null jika memilih kategori yang sudah ada
    required String title,
    required String body,
  });
}