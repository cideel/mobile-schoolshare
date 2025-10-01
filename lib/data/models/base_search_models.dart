import 'package:schoolshare/data/models/institution_model.dart'; // Assume this file exists

// Asumsi Model Institution (Diperlukan oleh custom_search_institution.dart)
// Jika Anda sudah memiliki ini, hapus definisi ini.
class Institution {
  final int id;
  final String name;
  Institution({required this.id, required this.name});
  factory Institution.fromJson(Map<String, dynamic> json) =>
      Institution(id: json['id'] ?? 0, name: json['name'] ?? '');
}

// Asumsi Model UserProfile (Diperlukan oleh people_search.dart)
class UserProfile {
  final String id;
  final String name;
  final String institution;
  final String profilePhoto;
  final String email;

  UserProfile({
    required this.id,
    required this.name,
    required this.institution,
    required this.profilePhoto,
    required this.email,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        id: json['id']?.toString() ?? '',
        name: json['name'] ?? 'Unknown User',
        institution: json['institution'] ?? 'Unknown Institution',
        profilePhoto: json['profile_photo'] ?? 'assets/images/placeholder.jpg',
        email: json['email'] ?? '',
      );
}

// Model untuk hasil pencarian Orang (People Search)
class UserSearchModel extends UserProfile {
  UserSearchModel({
    required super.id,
    required super.name,
    required super.institution,
    required super.profilePhoto,
    required super.email,
  });

  factory UserSearchModel.fromJson(Map<String, dynamic> json) =>
      UserSearchModel(
        id: json['id']?.toString() ?? '',
        name: json['name'] ?? 'Unknown User',
        institution: json['institution'] ?? 'Unknown Institution',
        profilePhoto: json['profile_photo'] ?? 'assets/images/placeholder.jpg',
        email: json['email'] ?? '',
      );
}

// Model untuk hasil pencarian Publikasi (Publication Search)
class PublicationSearchModel {
  final String id;
  final String title;
  final String type;
  final String date;
  final List<Map<String, dynamic>>
      authors; // Menggunakan Map sesuai struktur lama
  final int reads;

  PublicationSearchModel({
    required this.id,
    required this.title,
    required this.type,
    required this.date,
    required this.authors,
    required this.reads,
  });

  factory PublicationSearchModel.fromJson(Map<String, dynamic> json) =>
      PublicationSearchModel(
        id: json['id']?.toString() ?? '',
        title: json['title'] ?? 'No Title',
        type: json['type'] ?? 'Unknown',
        date: json['date'] ?? 'N/A',
        authors: (json['authors'] as List? ?? [])
            .map((a) => a as Map<String, dynamic>)
            .toList(),
        reads: json['reads'] ?? 0,
      );
}

// Model untuk hasil pencarian Diskusi (Discussion Search)
class DiscussionSearchModel {
  final String id;
  final String topic;
  final String title;
  final String author;
  final String authorPhoto;
  final DateTime createdAt;
  final int commentCount;
  final String description;

  DiscussionSearchModel({
    required this.id,
    required this.topic,
    required this.title,
    required this.author,
    required this.authorPhoto,
    required this.createdAt,
    required this.commentCount,
    required this.description,
  });

  factory DiscussionSearchModel.fromJson(Map<String, dynamic> json) =>
      DiscussionSearchModel(
        id: json['id']?.toString() ?? '',
        topic: json['topic'] ?? 'General',
        title: json['title'] ?? 'No Title',
        author: json['author_name'] ?? 'Unknown',
        authorPhoto: json['author_photo'] ?? 'assets/images/placeholder.jpg',
        // Asumsi API mengembalikan timestamp/ISO string
        createdAt:
            DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
        commentCount: json['comment_count'] ?? 0,
        description: json['description'] ?? '',
      );
}

// Asumsi model ContentSubmission.
// Diperlukan agar people_search.dart dapat mengkompilasi
class ContentSubmission {
  // Isi model yang sebenarnya
}
