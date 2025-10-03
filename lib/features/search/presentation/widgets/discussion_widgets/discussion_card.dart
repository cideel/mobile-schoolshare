import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolshare/core/constants/color.dart';
import 'package:schoolshare/core/constants/text_styles.dart';
import 'package:schoolshare/core/services/api_urls.dart';
import '../../../../../data/models/discussion_item.dart';

class DiscussionCard extends StatelessWidget {
  final DiscussionItem discussion;
  final VoidCallback? onTap;

  const DiscussionCard({
    super.key,
    required this.discussion,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(mq.size.width * 0.04),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey[200]!, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Topic Tag
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: mq.size.width * 0.025,
                vertical: mq.size.height * 0.004,
              ),
              decoration: BoxDecoration(
                color: AppColor.componentColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                discussion.category.name,
                style: AppTextStyle.caption.copyWith(
                  color: AppColor.componentColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            SizedBox(height: mq.size.height * 0.012),

            // Title
            Text(
              discussion.title,
              style: AppTextStyle.cardTitle.copyWith(fontSize: 16.sp),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),

            SizedBox(height: mq.size.height * 0.008),

            // Description
            Text(
              discussion.body,
              style: AppTextStyle.bodyText.copyWith(
                fontSize: 13.sp,
                color: Colors.grey[600],
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),

            SizedBox(height: mq.size.height * 0.012),

            // Author and Stats Row
            Row(
              children: [
                // Author Info
                CircleAvatar(
                  radius: mq.size.width * 0.025,
                  backgroundImage: _getImageProvider(discussion.author.profile),
                ),
                SizedBox(width: mq.size.width * 0.02),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        discussion.author.name,
                        style:
                            AppTextStyle.authorName.copyWith(fontSize: 12.sp),
                      ),
                      Text(
                        _getTimeAgo(discussion.createdAt),
                        style: AppTextStyle.caption.copyWith(
                          fontSize: 11.sp,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                ),

                // Comment Count
                Row(
                  children: [
                    Icon(
                      Icons.comment_outlined,
                      size: mq.size.width * 0.04,
                      color: Colors.grey[600],
                    ),
                    SizedBox(width: mq.size.width * 0.01),
                    Text(
                      '${discussion.commentCount}',
                      style: AppTextStyle.caption.copyWith(
                        fontSize: 12.sp,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return '${difference.inDays} hari lalu';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} jam lalu';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} menit lalu';
    } else {
      return 'Baru saja';
    }
  }

  ImageProvider _getImageProvider(String? photo) {
    if (photo != null && photo.isNotEmpty) {
      if (photo.startsWith('http://') || photo.startsWith('https://')) {
        return NetworkImage(photo);
      } else {
        final separator = photo.startsWith('/') ? '' : '/';
        return NetworkImage("${ApiUrls.storageUrl}$separator$photo");
      }
    }
    return const AssetImage('assets/images/example-profile.jpg');
  }
}
