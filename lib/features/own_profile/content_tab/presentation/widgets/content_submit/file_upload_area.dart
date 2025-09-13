import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolshare/core/constants/color.dart';
import 'package:schoolshare/core/constants/text_styles.dart';

class FileUploadArea extends StatelessWidget {
  final VoidCallback onTap;
  final List<String> acceptedFormats;
  final String maxFileSize;
  final bool hasFiles;

  const FileUploadArea({
    super.key,
    required this.onTap,
    this.acceptedFormats = const ['PDF', 'DOC', 'DOCX', 'PPT', 'PPTX'],
    this.maxFileSize = '10MB',
    this.hasFiles = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: hasFiles ? AppColor.componentColor.withOpacity(0.05) : Colors.grey.shade50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: hasFiles ? AppColor.componentColor.withOpacity(0.3) : Colors.grey.shade300,
            style: BorderStyle.solid,
          ),
        ),
        child: Column(
          children: [
            Icon(
              hasFiles ? Icons.cloud_done_outlined : Icons.cloud_upload_outlined,
              size: 40,
              color: hasFiles ? AppColor.componentColor : Colors.grey.shade600,
            ),
            const SizedBox(height: 12),
            Text(
              hasFiles ? 'Klik untuk menambah file lagi' : 'Klik untuk upload file',
              style: AppTextStyle.subtitle.copyWith(
                color: hasFiles ? AppColor.componentColor : Colors.black87,
                fontWeight: FontWeight.w500,
                fontSize: 15.sp,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Mendukung ${acceptedFormats.join(', ')}\nMaksimal $maxFileSize per file',
              textAlign: TextAlign.center,
              style: AppTextStyle.caption.copyWith(
                color: Colors.grey.shade600,
                fontSize: 13.sp,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
