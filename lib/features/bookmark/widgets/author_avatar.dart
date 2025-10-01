import 'package:flutter/material.dart';
import '../../../core/constants/color.dart';

class AuthorAvatar extends StatelessWidget {
  final String authorName;
  final double size;

  const AuthorAvatar({
    super.key,
    required this.authorName,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColor.componentColor,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: Center(
        child: Text(
          _getInitials(authorName),
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: size * 0.35,
          ),
        ),
      ),
    );
  }

  String _getInitials(String name) {
    final words = name.trim().split(' ');
    String initials = '';
    
    if (words.length >= 2) {
      initials = '${words[0][0].toUpperCase()}${words[1][0].toUpperCase()}';
    } else if (words.isNotEmpty) {
      initials = words[0][0].toUpperCase();
    } else {
      initials = 'A';
    }
    
    return initials;
  }
}