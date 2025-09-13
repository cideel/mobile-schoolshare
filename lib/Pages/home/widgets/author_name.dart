// lib/Pages/home/widgets/author_name.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolshare/Config/text_styles.dart';

class AuthorName extends StatelessWidget {
  final ImageProvider img;
  final String name;

  const AuthorName({
    super.key,
    required this.img,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return Row(
      children: [
        CircleAvatar(
          radius: mq.size.width * 0.035, // Responsive avatar size
          backgroundImage: img,
        ),
        SizedBox(width: mq.size.width * 0.02),
        Text(name, style: AppTextStyle.authorName.copyWith(fontSize: 14.sp)),
      ],
    );
  }
}
