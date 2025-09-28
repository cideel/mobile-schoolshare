import 'package:flutter/material.dart';
import '../../../../core/constants/color.dart';
import '../../../../core/constants/text_styles.dart';

class ContentAuthorAvatar extends StatelessWidget {
  final String authorName;
  final double size;

  const ContentAuthorAvatar({
    super.key,
    required this.authorName,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColor.componentColor,
        border: Border.all(
          color: AppColor.componentColor.withValues(alpha: 0.8),
          width: 1,
        ),
      ),
      child: Center(
        child: Text(
          _getInitials(authorName),
          style: AppTextStyle.caption.copyWith(
            fontSize: (mq.size.width * 0.025).clamp(9.0, 11.0),
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  String _getInitials(String name) {
    final words = name.split(' ');
    if (words.length >= 2) {
      return '${words[0][0]}${words[1][0]}'.toUpperCase();
    } else if (words.isNotEmpty) {
      return words[0][0].toUpperCase();
    }
    return 'A';
  }
}
