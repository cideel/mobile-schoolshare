class DiscussionItem {
  final String id;
  final String topic;
  final String title;
  final String description;
  final String author;
  final String authorPhoto;
  final DateTime createdAt;
  final int commentCount;

  DiscussionItem({
    required this.id,
    required this.topic,
    required this.title,
    required this.description,
    required this.author,
    required this.authorPhoto,
    required this.createdAt,
    required this.commentCount,
  });

  factory DiscussionItem.fromJson(Map<String, dynamic> json) {
    return DiscussionItem(
      id: json['id'] as String,
      topic: json['topic'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      author: json['author'] as String,
      authorPhoto: json['authorPhoto'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      commentCount: json['commentCount'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'topic': topic,
      'title': title,
      'description': description,
      'author': author,
      'authorPhoto': authorPhoto,
      'createdAt': createdAt.toIso8601String(),
      'commentCount': commentCount,
    };
  }
}

class CommentItem {
  final String id;
  final String content;
  final String author;
  final String authorPhoto;
  final DateTime createdAt;
  final List<CommentItem>? replies;

  CommentItem({
    required this.id,
    required this.content,
    required this.author,
    required this.authorPhoto,
    required this.createdAt,
    this.replies,
  });

  // Factory constructor for JSON parsing
  factory CommentItem.fromJson(Map<String, dynamic> json) {
    return CommentItem(
      id: json['id'] as String,
      content: json['content'] as String,
      author: json['author'] as String,
      authorPhoto: json['authorPhoto'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      replies: json['replies'] != null 
          ? (json['replies'] as List).map((r) => CommentItem.fromJson(r)).toList()
          : null,
    );
  }

  // Method to convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'author': author,
      'authorPhoto': authorPhoto,
      'createdAt': createdAt.toIso8601String(),
      'replies': replies?.map((r) => r.toJson()).toList(),
    };
  }

  // CopyWith method for creating updated instances
  CommentItem copyWith({
    String? id,
    String? content,
    String? author,
    String? authorPhoto,
    DateTime? createdAt,
    List<CommentItem>? replies,
  }) {
    return CommentItem(
      id: id ?? this.id,
      content: content ?? this.content,
      author: author ?? this.author,
      authorPhoto: authorPhoto ?? this.authorPhoto,
      createdAt: createdAt ?? this.createdAt,
      replies: replies ?? this.replies,
    );
  }
}
