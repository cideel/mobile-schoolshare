import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolshare/core/constants/text_styles.dart';

class PersonCard extends StatelessWidget {
  final String name;
  final String school;
  final String photoPath;
  final VoidCallback? onTap;

  const PersonCard({
    super.key,
    required this.name,
    required this.school,
    required this.photoPath,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    
    return Padding(
      padding: EdgeInsets.symmetric(vertical: mq.size.height * 0.008),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(
          horizontal: mq.size.width * 0.01,
        ),
        leading: CircleAvatar(
          backgroundImage: AssetImage(photoPath),
          radius: mq.size.width * 0.07, 
        ),
        title: Text(
          name,
          style: AppTextStyle.cardTitle.copyWith(
            fontSize: 16.sp,
          ),
        ),
        subtitle: Text(
          school,
          style: AppTextStyle.caption.copyWith(fontSize: 14.sp),
        ),
        onTap: onTap,
      ),
    );
  }
}
