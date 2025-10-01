// lib/data/models/publication.dart

import 'dart:convert';
import 'package:intl/intl.dart';

class AuthorModel {
  final int id;
  final String name;
  final String? profileUrl;

  AuthorModel({required this.id, required this.name, this.profileUrl});

  factory AuthorModel.fromJson(Map<String, dynamic> json) {
    return AuthorModel(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? 'Nama Tidak Tersedia',
      profileUrl: json['profile'] as String?,
    );
  }
}

class Publication {
  final int id;
  final String title;
  final String description;
  final String type;
  final String fileArticle;
  final DateTime publishedDate;
  final String videoUrl; 

  // 🔥 DIUBAH MENJADI NON-FINAL SESUAI PERMINTAAN
  int readCount; // total_readings
  int downloadCount; // total_downloaded
  int shareCount; // total_shared
  int likeCount; // total_recommendations

  // Status personal (Non-final sesuai permintaan)
  bool isRecommended;
  bool isBookmarked;

  final String uploaderName;
  final String uploaderInstitutionName;
  final String uploaderProfileUrl;

  final List<AuthorModel> authors;
  final List<AuthorModel> publishers;

  Publication({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.readCount,
    required this.likeCount,
    required this.downloadCount,
    required this.shareCount,
    required this.fileArticle,
    required this.publishedDate,
    required this.videoUrl,
    required this.isRecommended,
    required this.isBookmarked,
    required this.uploaderName,
    required this.uploaderInstitutionName,
    required this.uploaderProfileUrl,
    required this.authors,
    required this.publishers,
  });

  Publication copyWith({
    int? readCount,
    int? likeCount,
    int? downloadCount,
    int? shareCount,
    bool? isRecommended,
    bool? isBookmarked,
    String? videoUrl,
  }) {
    return Publication(
      id: id,
      title: title,
      description: description,
      type: type,
      fileArticle: fileArticle,
      videoUrl: videoUrl ?? this.videoUrl, 
      publishedDate: publishedDate,
      readCount: readCount ?? this.readCount,
      likeCount: likeCount ?? this.likeCount,
      downloadCount: downloadCount ?? this.downloadCount,
      shareCount: shareCount ?? this.shareCount,
      isRecommended: isRecommended ?? this.isRecommended,
      isBookmarked: isBookmarked ?? this.isBookmarked,
      uploaderName: uploaderName,
      uploaderInstitutionName: uploaderInstitutionName,
      uploaderProfileUrl: uploaderProfileUrl,
      authors: authors,
      publishers: publishers,
    );
  }

  factory Publication.fromJson(Map<String, dynamic> json) {
    final user = json['user'] as Map<String, dynamic>?;

    final List<AuthorModel> authorList = (json['authors'] as List? ?? [])
        .map((e) => AuthorModel.fromJson(e as Map<String, dynamic>))
        .toList();

    final List<AuthorModel> publisherList =
        (json['publisher_book_data'] as List? ?? [])
            .map((e) => AuthorModel.fromJson(e as Map<String, dynamic>))
            .toList();

    DateTime publishedDate =
        DateTime.tryParse(json['created_at'] as String? ?? '') ??
            DateTime.now();

    return Publication(
      id: json['id'] as int? ?? 0,
      title: json['name'] as String? ?? 'Judul Tidak Tersedia',
      description: json['description'] as String? ?? 'Tidak ada deskripsi.',
      type: json['type'] as String? ?? 'Dokumen',
      readCount: json['total_readings'] as int? ?? 0,
      likeCount: json['total_recommendations'] as int? ?? 0,
      downloadCount: json['total_downloaded'] as int? ?? 0,
      fileArticle: json['file_article'] as String? ?? '',
      videoUrl: json['video'] as String? ?? '',
      shareCount: json['total_shared'] as int? ?? 0,
      publishedDate: publishedDate,
      isRecommended: json['is_recommended_by_user'] as bool? ?? false,
      isBookmarked: json['is_bookmarked_by_user'] as bool? ?? false,
      uploaderName: user?['name'] as String? ?? 'Anonim',
      uploaderInstitutionName:
          user?['institusi']?['name'] as String? ?? 'Institusi Tidak Diketahui',
      uploaderProfileUrl: user?['profile'] as String? ?? '',
      authors: authorList,
      publishers: publisherList,
    );
  }

  String get formattedPublishedDate {
    return DateFormat('d MMMM yyyy', 'id_ID').format(publishedDate);
  }
}
