import 'package:flutter/material.dart';

class PersonCard extends StatelessWidget {
  final String name;
  final String school;
  final String? photoPath;
  final String? initials;
  final VoidCallback onTap;

  const PersonCard({
    super.key,
    required this.name,
    required this.school,
    this.photoPath,
    this.initials,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: (photoPath != null && photoPath!.isNotEmpty)
          ? CircleAvatar(
              backgroundImage: NetworkImage(photoPath!),
              radius: 24,
            )
          : CircleAvatar(
              radius: 24,
              backgroundColor: Colors.blue.shade600,
              child: Text(
                initials ?? "?",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
      title: Text(
        name,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(school),
      onTap: onTap,
    );
  }
}
