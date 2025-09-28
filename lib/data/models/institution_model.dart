class Institution {
  final int id;
  final String name;
  final String akronim;
  final String? profileInstitusi;
  final String location;
  final String? departemen;
  final String kategori;

  Institution(
      {required this.id,
      required this.name,
      required this.akronim,
      this.profileInstitusi,
      required this.location,
      this.departemen,
      required this.kategori});

  factory Institution.fromJson(Map<String, dynamic> json) {
    return Institution(
      id: json['id'] as int,
      name: json['name'] as String,
      akronim: json['akronim'] as String,
      profileInstitusi: json['profile_institusi'] as String?,
      location: json['location'] as String,
      departemen: json['departemen'] as String?,
      kategori: json['kategori'] as String,
    );
  }
}
