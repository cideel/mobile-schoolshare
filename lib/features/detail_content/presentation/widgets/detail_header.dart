import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolshare/core/constants/color.dart';
import 'package:schoolshare/core/constants/text_styles.dart';

class DetailHeader extends StatelessWidget {
  const DetailHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return SliverAppBar(
      pinned: true,
      centerTitle: false,
      backgroundColor: AppColor.componentColor,
      foregroundColor: Colors.white,
      title: Text(
        overflow: TextOverflow.ellipsis,
        'Proximate Analysis of Merang Mushrooms (Volvariella volvacea) Cultivated on Corncob and Rice Bran Media',
        style: AppTextStyle.cardTitle.copyWith(
          fontSize: 15.sp,
          color: Colors.white,
        ),
      ),
    );
  }
}
