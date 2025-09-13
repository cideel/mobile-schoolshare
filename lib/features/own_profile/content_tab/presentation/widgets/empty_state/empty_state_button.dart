import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolshare/core/constants/color.dart';
import 'package:schoolshare/core/constants/text_styles.dart';

class EmptyStateButton extends StatelessWidget {
  final VoidCallback onPressed;

  const EmptyStateButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return SizedBox(
      width: double.infinity,
      height: mq.size.height * 0.06,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.componentColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          "Tambahkan penelitian baru",
          style: AppTextStyle.badge.copyWith(
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
