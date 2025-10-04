// lib/features/own_profile/update_profile/presentation/widgets/profile_form_widget.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolshare/features/own_profile/update_profile/presentation/controllers/update_profile_controller.dart';
import 'package:schoolshare/core/constants/color.dart';

class ProfileFormWidget extends StatelessWidget {
  final UpdateProfileController controller;

  const ProfileFormWidget({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
                    // Name Field
          _buildModernFormField(
            label: 'Nama Lengkap',
            controller: controller.nameController,
            validator: controller.validateName,
            isRequired: true,
            hintText: 'Masukkan nama lengkap',
          ),

          SizedBox(height: 24.h),

          // Email Field
          _buildModernFormField(
            label: 'Email',
            controller: controller.emailController,
            validator: controller.validateEmail,
            isRequired: true,
            hintText: 'Masukkan email',
            keyboardType: TextInputType.emailAddress,
          ),

          SizedBox(height: 24.h),

          // Phone Field
          _buildModernFormField(
            label: 'Nomor Telepon',
            controller: controller.phoneController,
            validator: controller.validatePhone,
            isRequired: true,
            hintText: 'Masukkan nomor telepon',
            keyboardType: TextInputType.phone,
          ),
        ],
      ),
    );
  }

  Widget _buildModernFormField({
    required String label,
    required TextEditingController controller,
    required String? Function(String?)? validator,
    required bool isRequired,
    required String hintText,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Modern Label
        Padding(
          padding: EdgeInsets.only(left: 4.w, bottom: 8.h),
          child: RichText(
            text: TextSpan(
              text: label,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
                letterSpacing: 0.5,
              ),
              children: isRequired
                  ? [
                      TextSpan(
                        text: ' *',
                        style: TextStyle(
                          color: AppColor.componentColor,
                          fontSize: 14.sp,
                        ),
                      ),
                    ]
                  : null,
            ),
          ),
        ),
        
        // Modern Text Field
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TextFormField(
            controller: controller,
            validator: validator,
            keyboardType: keyboardType,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: Colors.grey[800],
            ),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w400,
                color: Colors.grey[400],
              ),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: Colors.grey[200]!,
                  width: 1.5,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: Colors.grey[200]!,
                  width: 1.5,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: AppColor.componentColor,
                  width: 2,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: Colors.red[400]!,
                  width: 1.5,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: Colors.red[400]!,
                  width: 2,
                ),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 18.h,
              ),
              errorStyle: TextStyle(
                fontSize: 12.sp,
                color: Colors.red[400],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
