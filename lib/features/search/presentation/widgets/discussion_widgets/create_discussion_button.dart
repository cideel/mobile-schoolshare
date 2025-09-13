import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolshare/core/constants/color.dart';
import 'package:schoolshare/core/constants/text_styles.dart';

class CreateDiscussionButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String buttonText;

  const CreateDiscussionButton({
    super.key,
    this.onPressed,
    this.buttonText = 'Buat Diskusi Baru',
  });

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(mq.size.width * 0.04),
      color: Colors.grey[50],
      child: ElevatedButton.icon(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.componentColor,
          minimumSize: Size(double.infinity, mq.size.height * 0.06),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        icon: Icon(
          Icons.add_comment_outlined,
          color: Colors.white,
          size: mq.size.width * 0.05,
        ),
        label: Text(
          buttonText,
          style: AppTextStyle.badge.copyWith(fontSize: 14.sp),
        ),
      ),
    );
  }
}
