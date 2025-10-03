// lib/features/search/domain/entities/discussion_item.dart

// Model untuk data user di dalam diskusi
class DiscussionUser {
final int id;
final String name;
final String? profile; // Menggunakan String? karena nilainya bisa null

DiscussionUser({
  required this.id,
  required this.name,
  this.profile,
});

factory DiscussionUser.fromJson(Map<String, dynamic> json) {
  return DiscussionUser(
    id: json['id'] as int,
    name: json['name'] as String,
    profile: json['profile'] as String?,
  );
}
}

// Model untuk kategori diskusi
class DiscussionCategory {
final int id;
final String name;

DiscussionCategory({
  required this.id,
  required this.name,
});

factory DiscussionCategory.fromJson(Map<String, dynamic> json) {
  return DiscussionCategory(
    id: json['id'] as int,
    name: json['name'] as String,
  );
}
}

// Model utama untuk item diskusi
class DiscussionItem {
final int id;
final String title;
final String body;
final DiscussionUser author;
final DiscussionCategory category;
final DateTime createdAt;
final int commentCount;

DiscussionItem({
  required this.id,
  required this.title,
  required this.body,
  required this.author,
  required this.category,
  required this.createdAt,
  required this.commentCount,
});

factory DiscussionItem.fromJson(Map<String, dynamic> json) {
  // Parsing created_at ke DateTime
  final createdAtString = json['created_at'] as String;

  // Pastikan field comment_count tersedia dan di-handle sebagai int
  int commentCountValue = 0;
  if (json.containsKey('comment_count')) {
    commentCountValue = (json['comment_count'] as num).toInt();
  }

  return DiscussionItem(
    id: json['id'] as int,
    title: json['title'] as String,
    body: json['body'] as String,
    // Menggunakan sub-factory constructor untuk objek nested
    author: DiscussionUser.fromJson(json['user'] as Map<String, dynamic>),
    category:
        DiscussionCategory.fromJson(json['category'] as Map<String, dynamic>),
    createdAt: DateTime.parse(createdAtString),
    commentCount: commentCountValue,
  );
}
factory DiscussionItem.empty() {
  return DiscussionItem(
    id: 0,
    title: '',
    body: '',
    commentCount: 0,
    author: DiscussionUser(id: 0, name: 'Loading', profile: null),
    category: DiscussionCategory(id: 0, name: 'Loading'),
    createdAt: DateTime.now(),
  );
}
}
