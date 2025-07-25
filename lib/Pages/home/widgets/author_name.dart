import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthorName extends StatelessWidget {
  final String img;
  final String name;

  const AuthorName({super.key, required this.img, required this.name});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 12,
          backgroundImage: AssetImage(img),
        ),
        const SizedBox(width: 8),
        Text(
          name,
          style: TextStyle(fontSize: 14.sp),
        )
      ],
    );
  }
}
