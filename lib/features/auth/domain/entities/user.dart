class User {
  final int id;
  final int roleGroupId;
  final List<dynamic>? institutionId; // JSON array
  final List<dynamic>? bookmarkId; // JSON array
  final String name;
  final String email;
  final String? phone;
  final String? profile; // text field that might contain profile data
  final int? totalSitasi;
  final int? hScore;
  final int? totalRecommendation;
  final int? readDocs;
  final String? password; // Usually not exposed in client-side models
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  final String? token;

  const User({
    required this.id,
    required this.roleGroupId,
    this.institutionId,
    required this.name,
    this.bookmarkId,
    required this.email,
    this.phone,
    this.profile,
    this.totalSitasi,
    this.hScore,
    this.totalRecommendation,
    this.readDocs,
    this.password,
    required this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.token,
  });

  String? get profileImage =>
      null; // Could be extracted from profile JSON if needed
  String get role => roleGroupId.toString(); // Convert role_group_id to string
  DateTime? get lastLoginAt => updatedAt; // Use updatedAt as approximation
  bool get isEmailVerified => true; // Default assumption
  String? get phoneNumber => phone;
  String? get university =>
      null; // Could be extracted from institutionId if needed
  String? get department =>
      null; // Could be extracted from institutionId if needed
}
