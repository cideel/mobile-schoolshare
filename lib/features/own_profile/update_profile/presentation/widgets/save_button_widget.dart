// lib/features/own_profile/update_profile/presentation/widgets/save_button_widget.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolshare/features/own_profile/update_profile/presentation/controllers/update_profile_controller.dart';
import 'package:schoolshare/core/constants/color.dart';

class SaveButtonWidget extends StatelessWidget {
  final UpdateProfileController controller;

  const SaveButtonWidget({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColor.componentColor.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: SizedBox(
        width: double.infinity,
        height: 56.h,
        child: ElevatedButton(
          onPressed: controller.isSaving ? null : controller.saveProfile,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.componentColor,
            foregroundColor: Colors.white,
            disabledBackgroundColor: Colors.grey[300],
            disabledForegroundColor: Colors.grey[600],
            elevation: 0,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: controller.isSaving
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 20.w,
                      height: 20.w,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2.5,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Text(
                      'Menyimpan...',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                )
              : Text(
                  'Simpan Perubahan',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.8,
                  ),
                ),
        ),
      ),
    );
  }
}
