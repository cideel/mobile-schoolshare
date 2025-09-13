import 'package:schoolshare/Models/content.dart';

/// Sebuah model yang disederhanakan untuk menampilkan data konten di UI.
/// Model ini memetakan data yang lebih kompleks dari API ke properti yang lebih
/// mudah digunakan dan relevan untuk tampilan.
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

  /// Factory constructor untuk membuat ContentItem dari objek Content.
  /// Ini mengonversi data API ke format UI yang disederhanakan.
  factory ContentItem.fromContent(Content content) {
    // Memetakan daftar objek User ke daftar nama penulis (String)
    final authorsList =
        content.authors?.map((user) => user.name).toList() ?? [];

    // Perhatikan: Data 'likes' dan 'comments' tidak ada di respons API yang diberikan.
    // Kami akan mengaturnya ke 0 untuk saat ini. Anda dapat memperbarui ini
    // jika API menyediakan data tersebut di masa depan.
    return ContentItem(
      title: content.name,
      description: content.description,
      datePosted: content.createdAt,
      likes: content.totalRecommendations ?? 0,
      comments: 0,
      contentType: content.type,
      authors: authorsList,
    );
  }
}
