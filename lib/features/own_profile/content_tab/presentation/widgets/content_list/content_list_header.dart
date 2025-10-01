import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolshare/core/constants/color.dart';
import 'package:schoolshare/core/constants/text_styles.dart';

class ContentListHeader extends StatelessWidget {
  final int contentCount;
  final VoidCallback onAddPressed;

  const ContentListHeader({
    super.key,
    required this.contentCount,
    required this.onAddPressed,
  });

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return Container(
      padding: EdgeInsets.symmetric(vertical: mq.size.height * 0.02),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Konten Saya',
                style: AppTextStyle.cardTitle.copyWith(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '$contentCount konten dipublikasikan',
                style: AppTextStyle.caption.copyWith(
                  fontSize: 13.sp,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              color: AppColor.componentColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: IconButton(
              onPressed: onAddPressed,
              icon: const Icon(Icons.add, color: Colors.white, size: 24),
              tooltip: 'Tambah konten baru',
            ),
          ),
        ],
      ),
    );
  }
}
