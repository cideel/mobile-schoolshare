import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolshare/core/constants/color.dart';
import 'package:schoolshare/core/constants/text_styles.dart';
import 'package:schoolshare/core/services/api_urls.dart';
import '../../../../../data/models/discussion_item.dart';

class DiscussionHeader extends StatelessWidget {
  final DiscussionItem discussion;

  const DiscussionHeader({
    super.key,
    required this.discussion,
  });

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return Container(
      padding: EdgeInsets.all(mq.size.width * 0.04),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Topic Tag
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: mq.size.width * 0.03,
              vertical: mq.size.height * 0.006,
            ),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              discussion.title,
              style: AppTextStyle.caption.copyWith(
                color: AppColor.componentColor,
                fontWeight: FontWeight.w600,
                fontSize: 12.sp,
              ),
            ),
          ),

          SizedBox(height: mq.size.height * 0.02),

          // Title
          Text(
            discussion.title,
            style: AppTextStyle.titleLarge.copyWith(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade800,
            ),
          ),

          SizedBox(height: mq.size.height * 0.015),

          // Author Info
          Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundImage: _getImageProvider(discussion.author.profile),
              ),
              SizedBox(width: mq.size.width * 0.03),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    discussion.author.name,
                    style: AppTextStyle.authorName.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    _formatTimeAgo(discussion.createdAt),
                    style: AppTextStyle.caption.copyWith(
                      fontSize: 12.sp,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: mq.size.height * 0.015),

          // Content
          Text(
            discussion.body,
            style: AppTextStyle.bodyText.copyWith(
              fontSize: 14.sp,
              height: 1.4,
              color: Colors.grey.shade700,
            ),
          ),

          SizedBox(height: mq.size.height * 0.015),

          // Stats Row
          Row(
            children: [
              Icon(
                Icons.comment_outlined,
                size: 16,
                color: Colors.grey.shade600,
              ),
              SizedBox(width: 4),
              Text(
                '${discussion.commentCount}',
                style: AppTextStyle.caption.copyWith(
                  color: Colors.grey.shade600,
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatTimeAgo(DateTime? dateTime) {
    if (dateTime == null) {
      return 'Waktu tidak diketahui';
    }

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
