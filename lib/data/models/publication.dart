// lib/data/models/publication.dart
class Publication {
  final String id;
  final String title;
  final String description;
  final String type;
  final List<String> authors;
  final String imageUrl;
  final DateTime publishedDate;
  final int readCount;
  final int likeCount;
  final String category;
  final String institutionName;

  Publication({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.authors,
    required this.imageUrl,
    required this.publishedDate,
    required this.readCount,
    required this.likeCount,
    required this.category,
    required this.institutionName,
  });

  factory Publication.fromJson(Map<String, dynamic> json) {
    return Publication(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      type: json['type'] as String,
      authors: List<String>.from(json['authors'] as List),
      imageUrl: json['imageUrl'] as String,
      publishedDate: DateTime.parse(json['publishedDate'] as String),
      readCount: json['readCount'] as int,
      likeCount: json['likeCount'] as int,
      category: json['category'] as String,
      institutionName: json['institutionName'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'type': type,
      'authors': authors,
      'imageUrl': imageUrl,
      'publishedDate': publishedDate.toIso8601String(),
      'readCount': readCount,
      'likeCount': likeCount,
      'category': category,
      'institutionName': institutionName,
    };
  }
}
