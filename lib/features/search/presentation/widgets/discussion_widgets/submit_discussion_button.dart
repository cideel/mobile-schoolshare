import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolshare/core/constants/color.dart';
import 'package:schoolshare/core/constants/text_styles.dart';

class SubmitDiscussionButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String buttonText;
  final bool isLoading;

  const SubmitDiscussionButton({
    super.key,
    this.onPressed,
    this.buttonText = 'Buat Diskusi',
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.componentColor,
          minimumSize: Size(double.infinity, mq.size.height * 0.06),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : Text(
                buttonText,
                style: AppTextStyle.badge.copyWith(fontSize: 16.sp),
              ),
      ),
    );
  }
}
