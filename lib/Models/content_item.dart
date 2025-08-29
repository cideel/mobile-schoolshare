class ContentItem {
  final String title;
  final String description;
  final String datePosted;
  final int likes;
  final int comments;
  final String contentType;
  final List<String> authors;

  ContentItem({
    required this.title,
    required this.description,
    required this.datePosted,
    required this.likes,
    required this.comments,
    required this.contentType,
    required this.authors,
  });
}
