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

  /// Factory constructor untuk membuat objek Institusi dari Map JSON.
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
