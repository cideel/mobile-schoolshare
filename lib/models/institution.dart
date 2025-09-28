class Institution {
  final String id;
  final String name;
  final String type; // 'university', 'school', 'institute'
  final String category; // 'Perguruan Tinggi', 'SMA', 'SMK', etc.
  final String? location;
  final String? description;
  final String? logoUrl;
  final bool isVerified;
  final DateTime createdAt;

  const Institution({
    required this.id,
    required this.name,
    required this.type,
    required this.category,
    this.location,
    this.description,
    this.logoUrl,
    this.isVerified = false,
    required this.createdAt,
  });

  factory Institution.fromJson(Map<String, dynamic> json) {
    return Institution(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      type: json['type'] ?? '',
      category: json['category'] ?? '',
      location: json['location'],
      description: json['description'],
      logoUrl: json['logoUrl'],
      isVerified: json['isVerified'] ?? false,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'category': category,
      'location': location,
      'description': description,
      'logoUrl': logoUrl,
      'isVerified': isVerified,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  Institution copyWith({
    String? id,
    String? name,
    String? type,
    String? category,
    String? location,
    String? description,
    String? logoUrl,
    bool? isVerified,
    DateTime? createdAt,
  }) {
    return Institution(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      category: category ?? this.category,
      location: location ?? this.location,
      description: description ?? this.description,
      logoUrl: logoUrl ?? this.logoUrl,
      isVerified: isVerified ?? this.isVerified,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  String toString() {
    return 'Institution(id: $id, name: $name, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Institution &&
        other.id == id &&
        other.name == name;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode;
  }
}
