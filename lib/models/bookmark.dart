class Bookmark {
  final String id;
  final String title;
  final List<String> authors;
  final String contentType;
  final int viewCount;
  final int downloadCount;
  final int recommendationCount;
  final DateTime bookmarkedAt;
  final String? institutionName;

  const Bookmark({
    required this.id,
    required this.title,
    required this.authors,
    required this.contentType,
    required this.viewCount,
    required this.downloadCount,
    required this.recommendationCount,
    required this.bookmarkedAt,
    this.institutionName,
  });

  factory Bookmark.fromJson(Map<String, dynamic> json) {
    return Bookmark(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      authors: List<String>.from(json['authors'] ?? []),
      contentType: json['contentType'] ?? '',
      viewCount: json['viewCount'] ?? 0,
      downloadCount: json['downloadCount'] ?? 0,
      recommendationCount: json['recommendationCount'] ?? 0,
      bookmarkedAt: DateTime.parse(json['bookmarkedAt'] ?? DateTime.now().toIso8601String()),
      institutionName: json['institutionName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'authors': authors,
      'contentType': contentType,
      'viewCount': viewCount,
      'downloadCount': downloadCount,
      'recommendationCount': recommendationCount,
      'bookmarkedAt': bookmarkedAt.toIso8601String(),
      'institutionName': institutionName,
    };
  }

  Bookmark copyWith({
    String? id,
    String? title,
    List<String>? authors,
    String? contentType,
    int? viewCount,
    int? downloadCount,
    int? recommendationCount,
    DateTime? bookmarkedAt,
    String? institutionName,
  }) {
    return Bookmark(
      id: id ?? this.id,
      title: title ?? this.title,
      authors: authors ?? this.authors,
      contentType: contentType ?? this.contentType,
      viewCount: viewCount ?? this.viewCount,
      downloadCount: downloadCount ?? this.downloadCount,
      recommendationCount: recommendationCount ?? this.recommendationCount,
      bookmarkedAt: bookmarkedAt ?? this.bookmarkedAt,
      institutionName: institutionName ?? this.institutionName,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Bookmark && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Bookmark{id: $id, title: $title, authors: $authors, contentType: $contentType}';
  }
}
