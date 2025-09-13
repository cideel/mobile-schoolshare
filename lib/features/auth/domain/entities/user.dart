
class User {
  final int id;
  final int roleGroupId;
  final List<dynamic>? instanceId; // JSON array
  final List<dynamic>? bookmarkId; // JSON array
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

  const User({
    required this.id,
    required this.roleGroupId,
    this.instanceId,
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
  });

  // Helper getters for backward compatibility
  String get name => profile ?? email.split('@').first; // Extract name from profile or email
  String? get profileImage => null; // Could be extracted from profile JSON if needed
  String get role => roleGroupId.toString(); // Convert role_group_id to string
  DateTime? get lastLoginAt => updatedAt; // Use updatedAt as approximation
  bool get isEmailVerified => true; // Default assumption
  String? get phoneNumber => phone;
  String? get university => null; // Could be extracted from instanceId if needed
  String? get department => null; // Could be extracted from instanceId if needed
}