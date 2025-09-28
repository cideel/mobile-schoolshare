class Comment {
  final String id;
  final String contentId;
  final String userId;
  final String userName;
  final String userAvatarUrl;
  final String text;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final int likesCount;
  final List<String> replies; // List of reply comment IDs
  final String? parentId; // For nested replies
  final bool isLikedByUser;

  const Comment({
    required this.id,
    required this.contentId,
    required this.userId,
    required this.userName,
    required this.userAvatarUrl,
    required this.text,
    required this.createdAt,
    this.updatedAt,
    this.likesCount = 0,
    this.replies = const [],
    this.parentId,
    this.isLikedByUser = false,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'] ?? '',
      contentId: json['contentId'] ?? '',
      userId: json['userId'] ?? '',
      userName: json['userName'] ?? '',
      userAvatarUrl: json['userAvatarUrl'] ?? '',
      text: json['text'] ?? '',
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : null,
      likesCount: json['likesCount'] ?? 0,
      replies: List<String>.from(json['replies'] ?? []),
      parentId: json['parentId'],
      isLikedByUser: json['isLikedByUser'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'contentId': contentId,
      'userId': userId,
      'userName': userName,
      'userAvatarUrl': userAvatarUrl,
      'text': text,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'likesCount': likesCount,
      'replies': replies,
      'parentId': parentId,
      'isLikedByUser': isLikedByUser,
    };
  }

  Comment copyWith({
    String? id,
    String? contentId,
    String? userId,
    String? userName,
    String? userAvatarUrl,
    String? text,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? likesCount,
    List<String>? replies,
    String? parentId,
    bool? isLikedByUser,
  }) {
    return Comment(
      id: id ?? this.id,
      contentId: contentId ?? this.contentId,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userAvatarUrl: userAvatarUrl ?? this.userAvatarUrl,
      text: text ?? this.text,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      likesCount: likesCount ?? this.likesCount,
      replies: replies ?? this.replies,
      parentId: parentId ?? this.parentId,
      isLikedByUser: isLikedByUser ?? this.isLikedByUser,
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

  bool get isReply => parentId != null;

  bool get hasReplies => replies.isNotEmpty;

  int get repliesCount => replies.length;

  @override
  String toString() {
    return 'Comment(id: $id, userName: $userName, text: ${text.length > 50 ? '${text.substring(0, 50)}...' : text})';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Comment && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}