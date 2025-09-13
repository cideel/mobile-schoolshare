import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolshare/core/constants/color.dart';
import 'package:schoolshare/core/constants/text_styles.dart';

class FormActionButtons extends StatelessWidget {
  final VoidCallback onSubmit;
  final VoidCallback? onCancel;
  final VoidCallback? onSaveDraft;
  final bool isLoading;
  final String submitText;
  final bool showDraftButton;

  const FormActionButtons({
    super.key,
    required this.onSubmit,
    this.onCancel,
    this.onSaveDraft,
    this.isLoading = false,
    this.submitText = 'SUBMIT KONTEN',
    this.showDraftButton = false,
  });

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return Column(
      children: [
        if (showDraftButton) ...[
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: isLoading ? null : onSaveDraft,
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: AppColor.componentColor),
                minimumSize: Size(double.infinity, mq.size.height * 0.055),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.save_outlined, color: AppColor.componentColor, size: 18),
                  const SizedBox(width: 8),
                  Text(
                    'SIMPAN SEBAGAI DRAFT',
                    style: AppTextStyle.badge.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColor.componentColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
        ],
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: isLoading ? null : onSubmit,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.componentColor,
              minimumSize: Size(double.infinity, mq.size.height * 0.06),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 0,
            ),
            child: isLoading
                ? SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Text(
                    submitText,
                    style: AppTextStyle.badge.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ),
        if (onCancel != null) ...[
          const SizedBox(height: 12),
          TextButton(
            onPressed: isLoading ? null : onCancel,
            child: Text(
              'Batal',
              style: AppTextStyle.bodyText.copyWith(
                color: Colors.grey.shade600,
                fontSize: 14.sp,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
