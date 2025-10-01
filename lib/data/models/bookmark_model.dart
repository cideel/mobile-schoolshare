class Author {
  final int id;
  final String name;
  final String? email;
  // Tambahkan properti lain yang relevan dari data API jika diperlukan

  Author({required this.id, required this.name, this.email});

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String?,
    );
  }
}

/// Model untuk data Publisher Book (Penerbit Buku)
/// Karena data API kosong, ini adalah model minimal.
class PublisherBookData {
  // Anda bisa menambahkan properti di sini jika data penerbit buku terisi
  PublisherBookData();

  factory PublisherBookData.fromJson(Map<String, dynamic> json) {
    return PublisherBookData();
  }
}

/// Model untuk data Content (Konten) yang ada di dalam bookmark.
class Content {
  final int id;
  final String name;
  final String description;
  final String type; // e.g., 'video', 'article'
  final String? video; // URL video jika tipe = video
  final String? fileArticle; // Path file jika tipe = article
  final List<Author> authors;
  final String category;
  final int totalReadings;
  final int totalRecommendations;

  Content({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    this.video,
    this.fileArticle,
    required this.authors,
    required this.category,
    required this.totalReadings,
    required this.totalRecommendations,
  });

  factory Content.fromJson(Map<String, dynamic> json) {
    return Content(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      type: json['type'] as String,
      video: json['video'] as String?,
      fileArticle: json['file_article'] as String?,
      category: json['category'] as String,
      totalReadings: json['total_readings'] as int? ?? 0,
      totalRecommendations: json['total_recommendations'] as int? ?? 0,
      authors: (json['authors'] as List<dynamic>?)
              ?.map((e) => Author.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

/// Model untuk objek Bookmark tunggal.
class Bookmark {
  final int id;
  final int userId;
  final int contentId;
  final Content content;

  Bookmark({
    required this.id,
    required this.userId,
    required this.contentId,
    required this.content,
  });

  factory Bookmark.fromJson(Map<String, dynamic> json) {
    return Bookmark(
      id: json['id'] as int,
      userId: json['user_id'] as int,
      contentId: json['content_id'] as int,
      content: Content.fromJson(json['content'] as Map<String, dynamic>),
    );
  }
}

/// Model untuk Response API penuh.
class BookmarkListResponse {
  final bool success;
  final String message;
  final List<Bookmark> data;

  BookmarkListResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory BookmarkListResponse.fromJson(Map<String, dynamic> json) {
    return BookmarkListResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => Bookmark.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
