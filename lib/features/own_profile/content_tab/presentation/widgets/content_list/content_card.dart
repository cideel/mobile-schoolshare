import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolshare/core/constants/text_styles.dart';
import 'package:schoolshare/core/constants/color.dart';
import 'content_statistics.dart';
import 'content_authors_list.dart';

class ContentCard extends StatelessWidget {
  final Map<String, dynamic> content;
  final VoidCallback onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const ContentCard({
    super.key,
    required this.content,
    required this.onTap,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return Container(
      margin: EdgeInsets.only(bottom: mq.size.height * 0.02),
      child: Card(
        
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
          side: const BorderSide(color: Colors.grey, width: 0.3),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(4),
          child: Padding(
            padding: EdgeInsets.all(mq.size.width * 0.03),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Content Type Badge and Category Label row with Menu
                _buildHeaderRow(mq),
                SizedBox(height: mq.size.height * 0.015),
                _buildContentTitle(),
                SizedBox(height: mq.size.height * 0.015),
                ContentAuthorsList(
                  authors: content['authors'] != null 
                    ? List<String>.from(content['authors']) 
                    : [], 
                  mediaQuery: mq
                ),
                ContentStatistics(content: content, mediaQuery: mq),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderRow(MediaQueryData mq) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Content Type Badge
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: mq.size.width * 0.03,
            vertical: mq.size.height * 0.008,
          ),
          decoration: BoxDecoration(
            color: AppColor.componentColor,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            content['typeLabel'] ?? 'Unknown',
            style: AppTextStyle.caption.copyWith(
              fontSize: 11.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
        
        const Spacer(),
        
        // Published date
        if (content['publishedDate'] != null)
          Padding(
            padding: EdgeInsets.only(top: mq.size.height * 0.008, right: mq.size.width * 0.02),
            child: Text(
              content['publishedDate'],
              style: AppTextStyle.caption.copyWith(
                fontSize: 10.sp,
                fontWeight: FontWeight.w400,
                color: Colors.grey.shade600,
              ),
            ),
          ),
        
        // Action Menu Button
        _buildActionMenu(),
      ],
    );
  }

  Widget _buildActionMenu() {
    if (onEdit == null && onDelete == null) return const SizedBox.shrink();
    
    return PopupMenuButton<String>(
      padding: EdgeInsets.zero,
      icon: Icon(
        Icons.more_horiz,
        size: 18.sp,
        color: Colors.grey.shade600,
      ),
      offset: const Offset(-20, 40),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: Colors.white,
      elevation: 4,
      onSelected: (value) => _handleMenuAction(value),
      itemBuilder: (context) => [
        if (onEdit != null)
          PopupMenuItem<String>(
            value: 'edit',
            height: 48,
            child: Row(
              children: [
                Icon(
                  Icons.edit_outlined, 
                  size: 16.sp, 
                  color: AppColor.componentColor,
                ),
                SizedBox(width: 12.w),
                Text(
                  'Edit Konten',
                  style: AppTextStyle.caption.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade800,
                  ),
                ),
              ],
            ),
          ),
        if (onDelete != null)
          PopupMenuItem<String>(
            value: 'delete',
            height: 48,
            child: Row(
              children: [
                Icon(
                  Icons.delete_outline, 
                  size: 16.sp, 
                  color: Colors.red.shade600,
                ),
                SizedBox(width: 12.w),
                Text(
                  'Hapus Konten',
                  style: AppTextStyle.caption.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.red.shade600,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  void _handleMenuAction(String action) {
    switch (action) {
      case 'edit':
        onEdit?.call();
        break;
      case 'delete':
        onDelete?.call();
        break;
    }
  }

  Widget _buildContentTitle() {
    return Text(
      content['title'] ?? 'Untitled',
      style: AppTextStyle.cardTitle.copyWith(
        fontSize: 16.sp,
        fontWeight: FontWeight.w700,
        height: 1.3,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }
}
