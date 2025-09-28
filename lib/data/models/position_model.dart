// lib/data/models/position_model.dart

class Position {
  final int id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Position({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Position.fromJson(Map<String, dynamic> json) {
    DateTime? _safeDateTime(dynamic value) {
      if (value == null) return null;
      return DateTime.tryParse(value.toString());
    }

    return Position(
      id: json['id'] as int,
      name: json['name'] as String,
      createdAt: _safeDateTime(json['created_at']) ?? DateTime.now(),
      updatedAt: _safeDateTime(json['updated_at']) ?? DateTime.now(),
    );
  }
}
