// CommentItem model for UI compatibility
// TODO: Migrate UI components to use Comment model from MVC

import 'package:schoolshare/models/models.dart';

class CommentItem {
  final String id;
  final String authorName;
  final String authorAvatar;
  final String content;
  final DateTime createdAt;
  final int likeCount;
  final bool isLiked;
  final List<CommentItem>? replies;
  final String? parentId;
  
  // Additional properties for UI compatibility
  final String author;
  final String authorPhoto;

  const CommentItem({
    required this.id,
    required this.authorName,
    required this.authorAvatar,
    required this.content,
    required this.createdAt,
    this.likeCount = 0,
    this.isLiked = false,
    this.replies,
    this.parentId,
    String? author,
    String? authorPhoto,
  }) : author = author ?? authorName,
       authorPhoto = authorPhoto ?? authorAvatar;

  // Factory constructor from Comment model
  factory CommentItem.fromComment(Comment comment, {List<CommentItem>? replies}) {
    return CommentItem(
      id: comment.id,
      authorName: comment.userName,
      authorAvatar: comment.userAvatarUrl,
      content: comment.text,
      createdAt: comment.createdAt,
      likeCount: comment.likesCount,
      isLiked: comment.isLikedByUser,
      replies: replies,
      parentId: comment.parentId,
    );
  }

  // Convert to Comment model (requires additional data)
  Comment toComment({required String contentId, required String userId}) {
    return Comment(
      id: id,
      contentId: contentId,
      userId: userId,
      userName: authorName,
      userAvatarUrl: authorAvatar,
      text: content,
      createdAt: createdAt,
      likesCount: likeCount,
      isLikedByUser: isLiked,
      parentId: parentId,
    );
  }

  CommentItem copyWith({
    String? id,
    String? authorName,
    String? authorAvatar,
    String? content,
    DateTime? createdAt,
    int? likeCount,
    bool? isLiked,
    List<CommentItem>? replies,
    String? parentId,
  }) {
    return CommentItem(
      id: id ?? this.id,
      authorName: authorName ?? this.authorName,
      authorAvatar: authorAvatar ?? this.authorAvatar,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      likeCount: likeCount ?? this.likeCount,
      isLiked: isLiked ?? this.isLiked,
      replies: replies ?? this.replies,
      parentId: parentId ?? this.parentId,
    );
  }
}
