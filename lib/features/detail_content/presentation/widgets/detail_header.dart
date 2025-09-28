import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolshare/core/constants/text_styles.dart';

class DetailHeader extends StatelessWidget {
  final String title;
  const DetailHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return SliverAppBar(
      pinned: true,
      centerTitle: false,
      expandedHeight: mq.size.height * 0.08,
      backgroundColor: Colors.white,
      title: Text(
        title,
        overflow: TextOverflow.ellipsis,
        style: AppTextStyle.cardTitle.copyWith(
          fontSize: 15.sp,
          color: Colors.black,
        ),
      ),
    );
  }
}
