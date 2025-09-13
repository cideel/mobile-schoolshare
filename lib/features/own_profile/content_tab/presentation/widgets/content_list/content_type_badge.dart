import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolshare/core/constants/color.dart';
import 'package:schoolshare/core/constants/text_styles.dart';

class ContentTypeBadge extends StatelessWidget {
  final String contentType;
  final String typeLabel;

  const ContentTypeBadge({
    super.key,
    required this.contentType,
    required this.typeLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: _getContentTypeColor(contentType),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
              const SizedBox(width: 6),
              Text(
                typeLabel,
                style: AppTextStyle.caption.copyWith(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Color _getContentTypeColor(String type) {
    switch (type) {
      case 'artikel': return AppColor.componentColor;
      case 'penelitian': return const Color(0xFF1E3A8A); // Blue solid
      case 'tutorial': return const Color(0xFF059669); // Green solid  
      case 'jurnal': return AppColor.componentColor;
      case 'video': return const Color(0xFFDC2626); // Red solid
      case 'ebook': return const Color(0xFF7C3AED); // Purple solid
      case 'presentasi': return const Color(0xFFEA580C); // Orange solid
      case 'laporan': return AppColor.componentColor;
      default: return AppColor.componentColor;
    }
  }
}
