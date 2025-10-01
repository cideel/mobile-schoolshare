import 'package:flutter/material.dart';
import '../../../core/constants/color.dart';
import '../../../core/constants/text_styles.dart';

class BookmarkAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BookmarkAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    
    return AppBar(
      backgroundColor: AppColor.componentColor,
      foregroundColor: Colors.white,
      elevation: 0,
      title: Text(
        'Bookmark Saya',
        style: AppTextStyle.titleLarge.copyWith(
          fontSize: mq.size.width * 0.048,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}