// lib/data/models/users_model.dart
import '../../features/auth/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.roleGroupId,
    super.institutionId,
    super.bookmarkId,
    required super.name,
    required super.email,
    super.phone,
    super.profile,
    super.totalSitasi,
    super.hScore,
    super.totalRecommendation,
    super.readDocs,
    super.password,
    required super.createdAt,
    super.updatedAt,
    super.deletedAt,
    super.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    int? _safeInt(dynamic value) {
      if (value == null) return null;
      if (value is int) return value;
      return int.tryParse(value.toString());
    }

    String? _safeString(dynamic value) {
      if (value == null) return null;
      return value.toString();
    }

    DateTime? _safeDateTime(dynamic value) {
      if (value == null) return null;
      return DateTime.tryParse(value.toString());
    }

    return UserModel(
      id: _safeInt(json['id']) ?? 0,
      roleGroupId: _safeInt(json['role_group_id']) ?? 1,
      institutionId: json['institusi'] != null
          ? [json['institusi']['name'] as String]
          : null,
      bookmarkId: json['bookmark_id'] is List
          ? List<dynamic>.from(json['bookmark_id'])
          : null,
      name: _safeString(json['name']) ?? 'Unknown',
      email: _safeString(json['email']) ?? 'unknown@email.com',
      phone: _safeString(json['phone']),
      profile: _safeString(json['profile']) ?? _safeString(json['name']),
      totalSitasi: _safeInt(json['total_sitasi']),
      hScore: _safeInt(json['ri_score']),
      totalRecommendation: _safeInt(json['total_recommendation']),
      readDocs: _safeInt(json['read_docs']),
      password: _safeString(json['password']),
      createdAt: _safeDateTime(json['created_at']) ?? DateTime.now(),
      updatedAt: _safeDateTime(json['updated_at']),
      deletedAt: _safeDateTime(json['deleted_at']),
      token: null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "role_group_id": roleGroupId,
      "institusi": institutionId,
      "bookmark_id": bookmarkId,
      "email": email,
      "phone": phone,
      "profile": profile,
      "total_sitasi": totalSitasi,
      "ri_score": hScore,
      "total_recommendation": totalRecommendation,
      "read_docs": readDocs,
      "password": password,
      "created_at": createdAt.toIso8601String(),
      "updated_at": updatedAt?.toIso8601String(),
      "deleted_at": deletedAt?.toIso8601String(),
    };
  }

  UserModel copyWith({
    int? id,
    int? roleGroupId,
    dynamic institutionId,
    List<dynamic>? bookmarkId,
    String? email,
    String? phone,
    String? profile,
    int? totalSitasi,
    int? hScore,
    int? totalRecommendation,
    int? readDocs,
    String? password,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    String? token,
  }) {
    return UserModel(
      id: id ?? this.id,
      roleGroupId: roleGroupId ?? this.roleGroupId,
      institutionId: institutionId ?? this.institutionId,
      bookmarkId: bookmarkId ?? this.bookmarkId,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      profile: profile ?? this.profile,
      totalSitasi: totalSitasi ?? this.totalSitasi,
      hScore: hScore ?? this.hScore,
      totalRecommendation: totalRecommendation ?? this.totalRecommendation,
      readDocs: readDocs ?? this.readDocs,
      password: password ?? this.password,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      token: token ?? this.token,
    );
  }
}
