// lib/features/discussion/domain/entities/comment_item.dart (FINAL FIX)

import 'package:schoolshare/data/models/discussion_item.dart';

class CommentItem {
  final int id;
  final int forumId;
  final String content;
  final DiscussionUser author;
  final int? parentId; // null jika komentar utama
  final DateTime? createdAt;
  List<CommentItem> replies = [];

  CommentItem({
    required this.id,
    required this.forumId,
    required this.content,
    required this.author,
    this.parentId,
    this.createdAt,
    this.replies = const [],
  });

  factory CommentItem.fromJson(Map<String, dynamic> json) {
    final createdAtString = json['created_at'] as String?;

    final userData = json['user'];

    final DiscussionUser commentAuthor;

    if (userData != null && userData is Map<String, dynamic>) {
      commentAuthor = DiscussionUser.fromJson(userData);
    } else {
      commentAuthor = DiscussionUser(
        id: json['user_id'] as int,
        name: 'Pengguna ID ${json['user_id']}',
        profile: null,
      );
    }

    return CommentItem(
      id: json['id'] as int,
      forumId: json['forum_id'] as int,
      content: json['body'] as String,
      author: commentAuthor,
      parentId: json['parent_id'] as int?,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      replies: [],
    );
  }

  CommentItem copyWith(
      {int? id,
      int? forumId,
      String? content,
      DiscussionUser? author,
      int? parentId,
      DateTime? createdAt,
      List<CommentItem>? replies}) {
    return CommentItem(
      id: id ?? this.id,
      forumId: forumId ?? this.forumId,
      content: content ?? this.content,
      author: author ?? this.author,
      parentId: parentId ?? this.parentId,
      createdAt: createdAt ?? this.createdAt,
      replies: replies ?? this.replies,
    );
  }
}
