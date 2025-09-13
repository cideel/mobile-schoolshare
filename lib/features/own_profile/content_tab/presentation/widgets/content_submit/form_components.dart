import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolshare/core/constants/color.dart';
import 'package:schoolshare/core/constants/text_styles.dart';

class FormComponents {
  static Widget buildTextField({
    required TextEditingController controller,
    required String hintText,
    String? Function(String?)? validator,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      style: AppTextStyle.bodyText.copyWith(fontSize: 14.sp),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppTextStyle.caption.copyWith(color: Colors.grey.shade500),
        filled: true,
        fillColor: Colors.grey.shade50,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColor.componentColor, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
      validator: validator,
    );
  }

  static Widget buildSelector({
    required VoidCallback onTap,
    required Widget child,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: child,
      ),
    );
  }

  static Widget buildSectionTitle(String title) {
    return Text(
      title,
      style: AppTextStyle.sectionTitle,
    );
  }

  static Widget buildSubmitButton({
    required VoidCallback onPressed,
    required MediaQueryData mediaQuery,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.componentColor,
          minimumSize: Size(double.infinity, mediaQuery.size.height * 0.06),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          'SUBMIT KONTEN',
          style: AppTextStyle.badge.copyWith(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  static Widget buildFileUploadArea({required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Colors.grey.shade300,
            style: BorderStyle.solid,
          ),
        ),
        child: Column(
          children: [
            Icon(
              Icons.cloud_upload_outlined,
              size: 40,
              color: AppColor.componentColor,
            ),
            const SizedBox(height: 12),
            Text(
              'Klik untuk upload file',
              style: AppTextStyle.subtitle.copyWith(
                color: Colors.black87,
                fontWeight: FontWeight.w500,
                fontSize: 15.sp,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Mendukung PDF, DOC, DOCX, PPT, PPTX\nMaksimal 10MB per file',
              textAlign: TextAlign.center,
              style: AppTextStyle.caption.copyWith(
                color: Colors.grey.shade600,
                fontSize: 13.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget buildUploadedFilesList({
    required List<String> files,
    required Function(String) onRemoveFile,
  }) {
    return Column(
      children: files.map((file) {
        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.green.shade200),
          ),
          child: Row(
            children: [
              Icon(
                Icons.insert_drive_file,
                color: Colors.green.shade700,
                size: 20,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      file,
                      style: AppTextStyle.bodyText.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 13.sp,
                      ),
                    ),
                    Text(
                      '2.5 MB',
                      style: AppTextStyle.caption.copyWith(
                        color: Colors.green.shade700,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => onRemoveFile(file),
                icon: Icon(
                  Icons.close,
                  color: Colors.red.shade700,
                  size: 20,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
