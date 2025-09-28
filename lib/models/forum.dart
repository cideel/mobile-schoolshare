class Forum {
  final String id;
  final String title;
  final String description;
  final String authorId;
  final String authorName;
  final String authorAvatarUrl;
  final String category;
  final List<String> tags;
  final int viewsCount;
  final int commentsCount;
  final int likesCount;
  final bool isLikedByUser;
  final bool isPinned;
  final bool isLocked;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const Forum({
    required this.id,
    required this.title,
    required this.description,
    required this.authorId,
    required this.authorName,
    required this.authorAvatarUrl,
    required this.category,
    this.tags = const [],
    this.viewsCount = 0,
    this.commentsCount = 0,
    this.likesCount = 0,
    this.isLikedByUser = false,
    this.isPinned = false,
    this.isLocked = false,
    required this.createdAt,
    this.updatedAt,
  });

  factory Forum.fromJson(Map<String, dynamic> json) {
    return Forum(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      authorId: json['authorId'] ?? '',
      authorName: json['authorName'] ?? '',
      authorAvatarUrl: json['authorAvatarUrl'] ?? '',
      category: json['category'] ?? '',
      tags: List<String>.from(json['tags'] ?? []),
      viewsCount: json['viewsCount'] ?? 0,
      commentsCount: json['commentsCount'] ?? 0,
      likesCount: json['likesCount'] ?? 0,
      isLikedByUser: json['isLikedByUser'] ?? false,
      isPinned: json['isPinned'] ?? false,
      isLocked: json['isLocked'] ?? false,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'authorId': authorId,
      'authorName': authorName,
      'authorAvatarUrl': authorAvatarUrl,
      'category': category,
      'tags': tags,
      'viewsCount': viewsCount,
      'commentsCount': commentsCount,
      'likesCount': likesCount,
      'isLikedByUser': isLikedByUser,
      'isPinned': isPinned,
      'isLocked': isLocked,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  Forum copyWith({
    String? id,
    String? title,
    String? description,
    String? authorId,
    String? authorName,
    String? authorAvatarUrl,
    String? category,
    List<String>? tags,
    int? viewsCount,
    int? commentsCount,
    int? likesCount,
    bool? isLikedByUser,
    bool? isPinned,
    bool? isLocked,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Forum(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      authorId: authorId ?? this.authorId,
      authorName: authorName ?? this.authorName,
      authorAvatarUrl: authorAvatarUrl ?? this.authorAvatarUrl,
      category: category ?? this.category,
      tags: tags ?? this.tags,
      viewsCount: viewsCount ?? this.viewsCount,
      commentsCount: commentsCount ?? this.commentsCount,
      likesCount: likesCount ?? this.likesCount,
      isLikedByUser: isLikedByUser ?? this.isLikedByUser,
      isPinned: isPinned ?? this.isPinned,
      isLocked: isLocked ?? this.isLocked,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(createdAt);

    if (difference.inDays > 0) {
      return '${difference.inDays}h yang lalu';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}j yang lalu';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m yang lalu';
    } else {
      return 'Baru saja';
    }
  }

  String get shortDescription {
    if (description.length <= 100) return description;
    return '${description.substring(0, 100)}...';
  }

  @override
  String toString() {
    return 'Forum(id: $id, title: $title, author: $authorName)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Forum && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}