class User {
  final String id;
  final String name;
  final String email;
  final String? avatar;
  final String institution;
  final String category;
  final String? position;
  final String? department;
  final String? location;
  final DateTime joinedDate;
  final bool isVerified;

  const User({
    required this.id,
    required this.name,
    required this.email,
    this.avatar,
    required this.institution,
    required this.category,
    this.position,
    this.department,
    this.location,
    required this.joinedDate,
    this.isVerified = false,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      avatar: json['avatar'],
      institution: json['institution'] ?? '',
      category: json['category'] ?? '',
      position: json['position'],
      department: json['department'],
      location: json['location'],
      joinedDate: json['joinedDate'] != null
          ? DateTime.parse(json['joinedDate'])
          : DateTime.now(),
      isVerified: json['isVerified'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'avatar': avatar,
      'institution': institution,
      'category': category,
      'position': position,
      'department': department,
      'location': location,
      'joinedDate': joinedDate.toIso8601String(),
      'isVerified': isVerified,
    };
  }

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? avatar,
    String? institution,
    String? category,
    String? position,
    String? department,
    String? location,
    DateTime? joinedDate,
    bool? isVerified,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      avatar: avatar ?? this.avatar,
      institution: institution ?? this.institution,
      category: category ?? this.category,
      position: position ?? this.position,
      department: department ?? this.department,
      location: location ?? this.location,
      joinedDate: joinedDate ?? this.joinedDate,
      isVerified: isVerified ?? this.isVerified,
    );
  }

  @override
  String toString() {
    return 'User(id: $id, name: $name, email: $email, institution: $institution)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.id == id &&
        other.name == name &&
        other.email == email;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ email.hashCode;
  }
}
