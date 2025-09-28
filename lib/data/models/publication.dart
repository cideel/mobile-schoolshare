// Compatibility layer for legacy Publication model
// TODO: Migrate UI components to use Content model from MVC

import 'package:schoolshare/models/models.dart';

class Publication {
  final String id;
  final String title;
  final String description;
  final String authorName;
  final String category;
  final int viewCount;
  final int downloadCount;
  final DateTime publishedDate;
  final List<String> tags;
  final String? thumbnailUrl;
  final bool isFree;

  const Publication({
    required this.id,
    required this.title,
    required this.description,
    required this.authorName,
    required this.category,
    this.viewCount = 0,
    this.downloadCount = 0,
    required this.publishedDate,
    this.tags = const [],
    this.thumbnailUrl,
    this.isFree = true,
  });

  // Factory constructor from Content model
  factory Publication.fromContent(Content content) {
    return Publication(
      id: content.id,
      title: content.title,
      description: content.description,
      authorName: content.authors.isNotEmpty ? content.authors.first : 'Unknown',
      category: content.type,
      viewCount: content.viewCount,
      downloadCount: content.downloadCount,
      publishedDate: content.createdAt,
      tags: content.tags,
      thumbnailUrl: content.thumbnailUrl,
      isFree: content.price == null || content.price == 0,
    );
  }

  // Convert to Content model
  Content toContent() {
    return Content(
      id: id,
      title: title,
      description: description,
      type: category,
      authors: [authorName],
      authorId: 'legacy_author',
      viewCount: viewCount,
      downloadCount: downloadCount,
      createdAt: publishedDate,
      tags: tags,
      thumbnailUrl: thumbnailUrl,
      price: isFree ? null : 0.0,
    );
  }
}
