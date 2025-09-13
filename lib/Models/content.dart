import 'dart:convert';

/// Model untuk merepresentasikan data institusi.
class Institusi {
  final int id;
  final String name;
  final String akronim;
  final String? profileInstitusi;
  final String? location;
  final String? departemen;
  final String kategori;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;

  Institusi({
    required this.id,
    required this.name,
    required this.akronim,
    this.profileInstitusi,
    this.location,
    this.departemen,
    required this.kategori,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory Institusi.fromJson(Map<String, dynamic> json) {
    return Institusi(
      id: json['id'] as int,
      name: json['name'] as String,
      akronim: json['akronim'] as String,
      profileInstitusi: json['profile_institusi'] as String?,
      location: json['location'] as String?,
      departemen: json['departemen'] as String?,
      kategori: json['kategori'] as String,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      deletedAt: json['deleted_at'] != null
          ? DateTime.parse(json['deleted_at'])
          : null,
    );
  }
}

/// Model untuk merepresentasikan data user, yang bisa menjadi author atau user utama.
class User {
  final int id;
  final int? roleGroupId;
  final int? institusiId;
  final String? positionId;
  final dynamic bookmarkId;
  final String name;
  final String email;
  final int phone;
  final String? profile;
  final int totalSitasi;
  final String riScore;
  final int totalRecommendation;
  final int readDocs;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  final Institusi? institusi;

  User({
    required this.id,
    this.roleGroupId,
    this.institusiId,
    this.positionId,
    this.bookmarkId,
    required this.name,
    required this.email,
    required this.phone,
    this.profile,
    required this.totalSitasi,
    required this.riScore,
    required this.totalRecommendation,
    required this.readDocs,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.institusi,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      roleGroupId: json['role_group_id'] as int?,
      institusiId: json['institusi_id'] as int?,
      positionId: json['position_id'] as String?,
      bookmarkId: json['bookmark_id'],
      name: json['name'] as String,
      email: json['email'] as String,
      phone: (json['phone'] as int),
      profile: json['profile'] as String?,
      totalSitasi: json['total_sitasi'] as int,
      riScore: json['ri_score'] as String,
      totalRecommendation: json['total_recommendation'] as int,
      readDocs: json['read_docs'] as int,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      deletedAt: json['deleted_at'] != null
          ? DateTime.parse(json['deleted_at'])
          : null,
      institusi: json['institusi'] != null
          ? Institusi.fromJson(json['institusi'])
          : null,
    );
  }
}

/// Model utama untuk merepresentasikan data konten.
class Content {
  final int id;
  final int userId;
  final String name;
  final String description;
  final String type;
  final String? authorArticle;
  final String? fileArticle;
  final String? isbnBook;
  final String? publisherBook;
  final List<User>? publisherBookData; // Properti baru untuk data penerbit
  final int? pagesBook;
  final String? reportNumberReport;
  final String? departmentReport;
  final String? video;
  final String? text;
  final int totalRecommendations;
  final int totalReadings;
  final int totalDownloaded;
  final int totalShared;
  final String category;
  final String createdAt;
  final String updatedAt;
  final String? deletedAt;
  final List<User>? authors;
  final User? user;

  Content({
    required this.id,
    required this.userId,
    required this.name,
    required this.description,
    required this.type,
    this.authorArticle,
    this.fileArticle,
    this.isbnBook,
    this.publisherBook,
    this.publisherBookData, // Tambahkan ke constructor
    this.pagesBook,
    this.reportNumberReport,
    this.departmentReport,
    this.video,
    this.text,
    required this.totalRecommendations,
    required this.totalReadings,
    required this.totalDownloaded,
    required this.totalShared,
    required this.category,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.authors,
    this.user,
  });

  factory Content.fromJson(Map<String, dynamic> json) {
    return Content(
      id: json['id'] as int,
      userId: json['user_id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      type: json['type'] as String,
      authorArticle: json['author_article'] as String?,
      fileArticle: json['file_article'] as String?,
      isbnBook: json['isbn_book'] as String?,
      publisherBook: json['publisher_book'] as String?,
      publisherBookData: (json['publisher_book_data'] as List<dynamic>?)
          ?.map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagesBook: json['pages_book'] as int?,
      reportNumberReport: json['report_number_report'] as String?,
      departmentReport: json['department_report'] as String?,
      video: json['video'] as String?,
      text: json['text'] as String?,
      totalRecommendations: json['total_recommendations'] as int,
      totalReadings: json['total_readings'] as int,
      totalDownloaded: json['total_downloaded'] as int,
      totalShared: json['total_shared'] as int,
      category: json['category'] as String,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
      deletedAt: json['deleted_at'] as String?,
      authors: (json['authors'] as List<dynamic>?)
          ?.map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }
}
