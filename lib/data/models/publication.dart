// lib/data/models/publication.dart (FINAL VERSION)

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

  // ✅ PERUBAHAN NAMA FIELD: fileArticle diubah menjadi filePath
  final String filePath;
  final DateTime publishedDate;
  final String videoUrl;

  // ✅ PENAMBAHAN FIELD: Metadata untuk Book, Report, dll.
  final Map<String, dynamic> metadata;

  // Status hitungan
  int readCount;
  int downloadCount;
  int shareCount;
  int likeCount;

  // Status personal
  bool isRecommended;
  bool isBookmarked;

  final String uploaderName;
  final String uploaderInstitutionName;
  final String uploaderProfileUrl;

  final List<AuthorModel> authors;

  // ❌ PENGHAPUSAN FIELD: publishers sudah dihapus dari API dan Model

  Publication({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.readCount,
    required this.likeCount,
    required this.downloadCount,
    required this.shareCount,

    // ✅ PERUBAHAN NAMA FIELD DI CONSTRUCTOR
    required this.filePath,
    required this.publishedDate,
    required this.videoUrl,
    required this.metadata, // ✅ PENAMBAHAN METADATA
    required this.isRecommended,
    required this.isBookmarked,
    required this.uploaderName,
    required this.uploaderInstitutionName,
    required this.uploaderProfileUrl,
    required this.authors,
    // publishers dihapus
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

      filePath: filePath, // Menggunakan filePath lama
      videoUrl: videoUrl ?? this.videoUrl,
      publishedDate: publishedDate,
      metadata: metadata,

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
    );
  }

  factory Publication.fromJson(Map<String, dynamic> json) {
    final user = json['user'] as Map<String, dynamic>?;
    final institusi = user?['institusi'] as Map<String, dynamic>?;

    final List<AuthorModel> authorList = (json['authors'] as List? ?? [])
        .map((e) => AuthorModel.fromJson(e as Map<String, dynamic>))
        .toList();

    DateTime publishedDate =
        DateTime.tryParse(json['created_at'] as String? ?? '') ??
            DateTime.now();

    // Pastikan metadata adalah Map
    final metadataJson = json['metadata'];
    final Map<String, dynamic> metadataMap =
        (metadataJson is Map) ? metadataJson.cast<String, dynamic>() : {};

    return Publication(
      id: json['id'] as int? ?? 0,
      title: json['name'] as String? ?? 'Judul Tidak Tersedia',
      description: json['description'] as String? ?? 'Tidak ada deskripsi.',
      type: json['type'] as String? ?? 'Dokumen',
      readCount: json['total_readings'] as int? ?? 0,
      likeCount: json['total_recommendations'] as int? ?? 0,
      downloadCount: json['total_downloaded'] as int? ?? 0,
      shareCount: json['total_shared'] as int? ?? 0,
      publishedDate: publishedDate,

      // ✅ MENGAMBIL DARI KUNCI 'file_path'
      filePath: json['file_path'] as String? ?? '',

      // ✅ MENGAMBIL DARI KUNCI 'video_url'
      videoUrl: json['video_url'] as String? ?? '',

      // ✅ MENGAMBIL DARI KUNCI 'metadata'
      metadata: metadataMap,

      isRecommended: json['is_recommended_by_user'] as bool? ?? false,
      isBookmarked: json['is_bookmarked_by_user'] as bool? ?? false,
      uploaderName: user?['name'] as String? ?? 'Anonim',
      uploaderInstitutionName:
          institusi?['name'] as String? ?? 'Institusi Tidak Diketahui',
      uploaderProfileUrl: user?['profile'] as String? ?? '',
      authors: authorList,
    );
  }

  String get formattedPublishedDate {
    return DateFormat('d MMMM yyyy', 'id_ID').format(publishedDate);
  }
}
