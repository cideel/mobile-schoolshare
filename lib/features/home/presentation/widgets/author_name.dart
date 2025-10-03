import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolshare/core/constants/text_styles.dart';
import 'package:schoolshare/core/services/api_urls.dart';

class AuthorName extends StatelessWidget {
  final String img;
  final String name;

  const AuthorName({
    super.key,
    required this.img,
    required this.name,
  });

  ImageProvider _getImageProvider(String img) {
    if (img.isNotEmpty) {
      if (img.startsWith('http://') || img.startsWith('https://')) {
        // Kasus: sudah URL lengkap
        return NetworkImage(img);
      } else {
        // Kasus: path relatif dari storage
        final separator = img.startsWith('/') ? '' : '/';
        return NetworkImage("${ApiUrls.storageUrl}$separator$img");
      }
    }
    // Fallback default asset
    return const AssetImage('assets/images/example-profile.jpg');
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return Row(
      children: [
        CircleAvatar(
          radius: mq.size.width * 0.03,
          backgroundImage: _getImageProvider(img),
        ),
        SizedBox(width: mq.size.width * 0.02),
        Text(
          name,
          style: AppTextStyle.authorName.copyWith(fontSize: 14.sp),
        ),
      ],
    );
  }
}
