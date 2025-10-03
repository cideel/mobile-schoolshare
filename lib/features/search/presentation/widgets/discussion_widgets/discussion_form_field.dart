// lib/features/discussion/widgets/discussion_widgets/discussion_form_field.dart (PERBAIKAN)

import 'package:flutter/material.dart';
import 'package:schoolshare/core/constants/color.dart';
import 'package:schoolshare/core/constants/text_styles.dart';

class DiscussionFormField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String hintText;
  final int maxLines;
  final String? Function(String?)? validator;
  final bool readOnly; // Ditambahkan untuk field Topik yang Read-Only
  final String? errorText; // ✅ PARAMETER BARU: errorText

  const DiscussionFormField({
    super.key,
    required this.label,
    required this.controller,
    required this.hintText,
    this.maxLines = 1,
    this.validator,
    this.readOnly = false, // Nilai default
    this.errorText, // ✅ PARAMETER BARU
  });

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyle.sectionTitle,
        ),
        SizedBox(height: mq.size.height * 0.012),
        TextFormField(
          controller: controller,
          style: AppTextStyle.bodyText,
          maxLines: maxLines,
          readOnly: readOnly, // Digunakan untuk field Topik
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: AppTextStyle.caption,
            // ✅ PENGGUNAAN PARAMETER BARU DI SINI:
            errorText: errorText,

            // Atur warna border saat ada errorText
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.red, width: 2.0),
            ),

            // Border standar
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColor.componentColor),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: mq.size.width * 0.04,
              vertical: mq.size.height * 0.015,
            ),
          ),
          validator: validator,
        ),
      ],
    );
  }
}
