import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolshare/core/constants/color.dart';
import 'package:schoolshare/core/constants/text_styles.dart';
import 'package:schoolshare/models/models.dart';

class EditFormHeader extends StatelessWidget {
  final Publication publication;
  final MediaQueryData mediaQuery;

  const EditFormHeader({
    super.key,
    required this.publication,
    required this.mediaQuery,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade200,
            width: 1,
          ),
        ),
      ),
      padding: EdgeInsets.all(mediaQuery.size.width * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.w,
                  vertical: 4.h,
                ),
                decoration: BoxDecoration(
                  color: AppColor.componentColor,
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Text(
                  publication.type,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  'Sedang mengedit konten',
                  style: AppTextStyle.caption.copyWith(
                    fontSize: 12.sp,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: mediaQuery.size.height * 0.01),
          Text(
            publication.title,
            style: AppTextStyle.cardTitle.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: mediaQuery.size.height * 0.008),
          Row(
            children: [
              Icon(
                Icons.schedule,
                size: 14.sp,
                color: Colors.grey.shade500,
              ),
              SizedBox(width: 4.w),
              Text(
                _formatDate(publication.publishedDate),
                style: AppTextStyle.caption.copyWith(
                  fontSize: 12.sp,
                  color: Colors.grey.shade600,
                ),
              ),
              SizedBox(width: 16.w),
              Icon(
                Icons.visibility_outlined,
                size: 14.sp,
                color: Colors.grey.shade500,
              ),
              SizedBox(width: 4.w),
              Text(
                '${publication.readCount}',
                style: AppTextStyle.caption.copyWith(
                  fontSize: 12.sp,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
      'Jul', 'Agt', 'Sep', 'Okt', 'Nov', 'Des'
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }
}
