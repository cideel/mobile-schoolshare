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
}
