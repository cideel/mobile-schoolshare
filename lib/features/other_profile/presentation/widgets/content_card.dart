import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolshare/core/constants/color.dart';
import 'package:schoolshare/core/constants/text_styles.dart';

class ContentCard extends StatelessWidget {
  final String title;
  final String type;
  final List<String> authors;
  final int views;
  final int likes;
  final String date;

  const ContentCard({
    super.key,
    required this.title,
    required this.type,
    required this.authors,
    required this.views,
    required this.likes,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    
    return Card(
      elevation: 2,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: EdgeInsets.all(mq.size.width * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Content Type Badge
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 8.w,
                vertical: 4.h,
              ),
              decoration: BoxDecoration(
                color: AppColor.componentColor,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                type,
                style: AppTextStyle.caption.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            
            SizedBox(height: mq.size.height * 0.012),
            
            // Title
            Text(
              title,
              style: AppTextStyle.bodyText.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 16.sp,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            
            SizedBox(height: mq.size.height * 0.008),
            
            // Authors
            Text(
              'Oleh: ${authors.join(', ')}',
              style: AppTextStyle.caption.copyWith(
                color: Colors.grey.shade600,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            
            SizedBox(height: mq.size.height * 0.015),
            
            // Stats and Date
            Row(
              children: [
                Icon(
                  Icons.visibility_outlined,
                  size: 16.sp,
                  color: Colors.grey.shade600,
                ),
                SizedBox(width: 4.w),
                Text(
                  '$views',
                  style: AppTextStyle.caption.copyWith(
                    color: Colors.grey.shade600,
                  ),
                ),
                
                SizedBox(width: 16.w),
                
                Icon(
                  Icons.favorite_outline,
                  size: 16.sp,
                  color: Colors.grey.shade600,
                ),
                SizedBox(width: 4.w),
                Text(
                  '$likes',
                  style: AppTextStyle.caption.copyWith(
                    color: Colors.grey.shade600,
                  ),
                ),
                
                const Spacer(),
                
                Text(
                  date,
                  style: AppTextStyle.caption.copyWith(
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
