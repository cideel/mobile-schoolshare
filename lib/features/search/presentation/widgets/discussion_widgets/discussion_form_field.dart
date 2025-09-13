import 'package:flutter/material.dart';
import 'package:schoolshare/core/constants/color.dart';
import 'package:schoolshare/core/constants/text_styles.dart';

class DiscussionFormField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String hintText;
  final int maxLines;
  final String? Function(String?)? validator;

  const DiscussionFormField({
    super.key,
    required this.label,
    required this.controller,
    required this.hintText,
    this.maxLines = 1,
    this.validator,
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
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: AppTextStyle.caption,
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
