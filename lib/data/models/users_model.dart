// lib/data/models/users_model.dart
import '../../features/auth/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.roleGroupId,
    super.instanceId,
    super.bookmarkId,
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
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      roleGroupId: json['role_group_id'] as int? ?? 1, // Default to 1 if null
      instanceId: json['instance_id'] as List<dynamic>?,
      bookmarkId: json['bookmark_id'] as List<dynamic>?,
      email: json['email'] as String,
      phone: json['phone'] as String?,
      profile: json['profile'] as String? ?? json['name'] as String?, // Fallback to 'name' if 'profile' not exists
      totalSitasi: json['total_sitasi'] as int?,
      hScore: json['h_score'] as int?,
      totalRecommendation: json['total_recommendation'] as int?,
      readDocs: json['read_docs'] as int?,
      password: json['password'] as String?, // Usually omitted for security
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] != null 
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
      deletedAt: json['deletedAt'] != null 
          ? DateTime.parse(json['deletedAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'role_group_id': roleGroupId,
      'instance_id': instanceId,
      'bookmark_id': bookmarkId,
      'email': email,
      'phone': phone,
      'profile': profile,
      'total_sitasi': totalSitasi,
      'h_score': hScore,
      'total_recommendation': totalRecommendation,
      'read_docs': readDocs,
      // 'password': password, // Usually omitted for security
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
    };
  }

  // Method to create a copy with updated fields
  UserModel copyWith({
    int? id,
    int? roleGroupId,
    List<dynamic>? instanceId,
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
  }) {
    return UserModel(
      id: id ?? this.id,
      roleGroupId: roleGroupId ?? this.roleGroupId,
      instanceId: instanceId ?? this.instanceId,
      bookmarkId: bookmarkId ?? this.bookmarkId,
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
    );
  }
}