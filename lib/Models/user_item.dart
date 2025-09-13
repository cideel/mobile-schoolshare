import 'package:schoolshare/Models/content.dart';

/// Model untuk merepresentasikan data posisi.
class Position {
  final int id;
  final String name;

  Position({
    required this.id,
    required this.name,
  });

  factory Position.fromJson(Map<String, dynamic> json) {
    return Position(
      id: json['id'] as int,
      name: json['name'] as String,
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
  final String? createdAt;
  final String? updatedAt;
  final String? deletedAt;
  final Institusi? institusi;
  final Position? position;

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
    this.position,
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
      phone: (json['phone'] is String)
          ? int.parse(json['phone'])
          : json['phone'] as int,
      profile: json['profile'] as String?,
      totalSitasi: json['total_sitasi'] as int,
      riScore: json['ri_score'] as String,
      totalRecommendation: json['total_recommendation'] as int,
      readDocs: json['read_docs'] as int,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      deletedAt: json['deleted_at'] as String?,
      institusi: json['institusi'] != null
          ? Institusi.fromJson(json['institusi'])
          : null,
      position:
          json['position'] != null ? Position.fromJson(json['position']) : null,
    );
  }
}
