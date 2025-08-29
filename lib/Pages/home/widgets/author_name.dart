import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolshare/Config/text_styles.dart';

class AuthorName extends StatelessWidget {
  final String img;
  final String name;

  const AuthorName({super.key, required this.img, required this.name});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return Row(
      children: [
        CircleAvatar(
          radius: mq.size.width * 0.03, // Responsive avatar size
          backgroundImage: AssetImage(img),
        ),
        SizedBox(width: mq.size.width * 0.02), // Responsive spacing
        Text(
          name,
          style: AppTextStyle.authorName.copyWith(fontSize: 14.sp),
        )
      ],
    );
  }
}
