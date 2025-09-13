enum ContentStatus {
  draft,
  submitted,
  published,
  rejected,
}

class ContentSubmission {
  final String id;
  final String title;
  final String description;
  final ContentType contentType;
  final List<String> authors;
  final String? documentPath;
  final DateTime createdAt;
  final String submittedBy;
  final ContentStatus status;
  final DateTime? publishedAt;
  final String? rejectionReason;

  ContentSubmission({
    required this.id,
    required this.title,
    required this.description,
    required this.contentType,
    required this.authors,
    this.documentPath,
    required this.createdAt,
    required this.submittedBy,
    this.status = ContentStatus.draft,
    this.publishedAt,
    this.rejectionReason,
  });

  factory ContentSubmission.fromJson(Map<String, dynamic> json) {
    return ContentSubmission(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      contentType: ContentType.values.firstWhere(
        (type) => type.name == json['contentType'],
        orElse: () => ContentType.artikel,
      ),
      authors: List<String>.from(json['authors'] as List),
      documentPath: json['documentPath'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      submittedBy: json['submittedBy'] as String,
      status: ContentStatus.values.firstWhere(
        (status) => status.name == json['status'],
        orElse: () => ContentStatus.draft,
      ),
      publishedAt: json['publishedAt'] != null 
          ? DateTime.parse(json['publishedAt'] as String) 
          : null,
      rejectionReason: json['rejectionReason'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'contentType': contentType.name,
      'authors': authors,
      'documentPath': documentPath,
      'createdAt': createdAt.toIso8601String(),
      'submittedBy': submittedBy,
      'status': status.name,
      'publishedAt': publishedAt?.toIso8601String(),
      'rejectionReason': rejectionReason,
    };
  }
}

enum ContentType {
  artikel('Artikel'),
  jurnal('Jurnal'),
  video('Video'),
  podcast('Podcast'),
  presentasi('Presentasi'),
  buku('Buku'),
  thesis('Thesis/Skripsi'),
  penelitian('Penelitian'),
  tutorial('Tutorial');

  const ContentType(this.displayName);
  final String displayName;
}

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

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'] as String,
      name: json['name'] as String,
      institution: json['institution'] as String,
      profilePhoto: json['profilePhoto'] as String,
      email: json['email'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'institution': institution,
      'profilePhoto': profilePhoto,
      'email': email,
    };
  }
}
