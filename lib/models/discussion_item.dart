// DiscussionItem class for UI compatibility
class DiscussionItem {
  final String id;
  final String title;
  final String content;
  final String authorName;
  final DateTime createdAt;
  final int repliesCount;
  final int likesCount;
  
  // Additional properties for UI compatibility
  final String topic;
  final String description;
  final String author;
  final String authorPhoto;
  final String authorAvatar;
  final int commentCount;

  const DiscussionItem({
    required this.id,
    required this.title,
    required this.content,
    required this.authorName,
    required this.createdAt,
    this.repliesCount = 0,
    this.likesCount = 0,
    this.topic = '',
    this.description = '',
    this.author = '',
    this.authorPhoto = '',
    this.authorAvatar = '',
    this.commentCount = 0,
  });
}
