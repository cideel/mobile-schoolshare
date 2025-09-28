class Content {
  final String id;
  final String title;
  final String description;
  final String type;
  final List<String> authors;
  final String authorId;
  final String institutionName;
  final int viewCount;
  final int downloadCount;
  final int shareCount;
  final int recommendationCount;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isPublished;
  final String? fileUrl;
  final String? thumbnailUrl;
  final List<String> tags;
  final double? price;

  const Content({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.authors,
    required this.authorId,
    this.institutionName = '',
    this.viewCount = 0,
    this.downloadCount = 0,
    this.shareCount = 0,
    this.recommendationCount = 0,
    required this.createdAt,
    DateTime? updatedAt,
    this.isPublished = false,
    this.fileUrl,
    this.thumbnailUrl,
    this.tags = const [],
    this.price,
  }) : updatedAt = updatedAt ?? createdAt;

  factory Content.fromJson(Map<String, dynamic> json) {
    return Content(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      type: json['type'] ?? '',
      authors: List<String>.from(json['authors'] ?? []),
      authorId: json['authorId'] ?? '',
      institutionName: json['institutionName'] ?? '',
      viewCount: json['viewCount'] ?? 0,
      downloadCount: json['downloadCount'] ?? 0,
      shareCount: json['shareCount'] ?? 0,
      recommendationCount: json['recommendationCount'] ?? 0,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : DateTime.now(),
      isPublished: json['isPublished'] ?? false,
      fileUrl: json['fileUrl'],
      thumbnailUrl: json['thumbnailUrl'],
      tags: List<String>.from(json['tags'] ?? []),
      price: json['price']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'type': type,
      'authors': authors,
      'authorId': authorId,
      'institutionName': institutionName,
      'viewCount': viewCount,
      'downloadCount': downloadCount,
      'shareCount': shareCount,
      'recommendationCount': recommendationCount,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'isPublished': isPublished,
      'fileUrl': fileUrl,
      'thumbnailUrl': thumbnailUrl,
      'tags': tags,
      'price': price,
    };
  }

  Content copyWith({
    String? id,
    String? title,
    String? description,
    String? type,
    List<String>? authors,
    String? authorId,
    String? institutionName,
    int? viewCount,
    int? downloadCount,
    int? shareCount,
    int? recommendationCount,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isPublished,
    String? fileUrl,
    String? thumbnailUrl,
    List<String>? tags,
    double? price,
  }) {
    return Content(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      type: type ?? this.type,
      authors: authors ?? this.authors,
      authorId: authorId ?? this.authorId,
      institutionName: institutionName ?? this.institutionName,
      viewCount: viewCount ?? this.viewCount,
      downloadCount: downloadCount ?? this.downloadCount,
      shareCount: shareCount ?? this.shareCount,
      recommendationCount: recommendationCount ?? this.recommendationCount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isPublished: isPublished ?? this.isPublished,
      fileUrl: fileUrl ?? this.fileUrl,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      tags: tags ?? this.tags,
      price: price ?? this.price,
    );
  }

  // Getter aliases for backwards compatibility
  int get viewsCount => viewCount;
  int get downloadsCount => downloadCount;
  int get recommendationsCount => recommendationCount;
  String get name => title; // Alias for title

  String get formattedDate {
    final now = DateTime.now();
    final difference = now.difference(createdAt);

    if (difference.inDays > 0) {
      return '${difference.inDays} hari yang lalu';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} jam yang lalu';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} menit yang lalu';
    } else {
      return 'Baru saja';
    }
  }

  bool get isFree => price == null || price == 0;

  @override
  String toString() {
    return 'Content(id: $id, title: $title, type: $type, authorId: $authorId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Content &&
        other.id == id &&
        other.title == title &&
        other.authorId == authorId;
  }

  @override
  int get hashCode {
    return id.hashCode ^ title.hashCode ^ authorId.hashCode;
  }
}
